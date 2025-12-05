<?php
require_once 'secure_session.php';
require_once 'secure_headers.php';
require_once 'db.php';
require_once 'tcpdf/tcpdf.php';
require_once 'risk_engine_v2.php';   // for MODEL_VERSION + calculateComplianceV2
require_once 'csrf.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST' || !csrf_validate($_POST['csrf_token'] ?? '')) {
    $_SESSION['product_message'] = "❌ Netinkama užklausa.";
    header("Location: userdashboard.php"); exit();
}
if (!isset($_SESSION['user_id']) || ($_SESSION['role'] ?? '') !== 'naudotojas') {
    $_SESSION['product_message'] = "❌ Prieiga negalima: prisijunkite kaip naudotojas.";
    header("Location: login.php"); exit();
}

$productId = (int)($_POST['product_id'] ?? 0);
if ($productId <= 0) { $_SESSION['product_message'] = "❌ Klaida: trūksta produkto ID."; header("Location: userdashboard.php"); exit(); }

$userId = (int)$_SESSION['user_id'];

try {
    $stmt = $pdo->prepare("SELECT * FROM produktas WHERE ID = ?");
    $stmt->execute([$productId]);
    $product = $stmt->fetch(PDO::FETCH_ASSOC);
    if (!$product) throw new RuntimeException("Produktas nerastas.");

    // === Run model (now returns metadata) ===
    $res        = calculateComplianceV2($pdo, $productId);
    $AB         = $res['ab'];
    $status     = $res['status'];
    $komentaras = $res['comment'];
    $breakdown  = $res['breakdown'];
    $modelMeta  = $res['model'];
    $modelJson  = json_encode($modelMeta, JSON_UNESCAPED_UNICODE|JSON_UNESCAPED_SLASHES);

    // === Save row with ModelVersion + ModelConfig ===
    $stmt = $pdo->prepare("
        INSERT INTO atitiktiespatikra
          (Statusas, Data, Komentarai, ProduktasID, VartotojasID, AB, Breakdown, ModelVersion, ModelConfig)
        VALUES
          (?, NOW(), ?, ?, ?, ?, ?, ?, ?)
    ");
    $stmt->execute([
        $status, $komentaras, $productId, $userId, $AB,
        json_encode($breakdown, JSON_UNESCAPED_UNICODE|JSON_UNESCAPED_SLASHES),
        $modelMeta['version'] ?? null, $modelJson
    ]);

    // === Generate PDF (show model info) ===
    $reportsDir = __DIR__ . '/ataskaitos';
    if (!is_dir($reportsDir)) { @mkdir($reportsDir, 0775, true); }

    $pdf = new TCPDF();
    $pdf->SetFont('dejavusans', '', 10);
    $pdf->AddPage();

    $rows = '';
    foreach ($breakdown as $b) {
        $rule    = htmlspecialchars((string)($b['rule'] ?? ''), ENT_QUOTES, 'UTF-8');
        $value   = htmlspecialchars((string)($b['value'] ?? ''), ENT_QUOTES, 'UTF-8');
        $norm    = isset($b['norm'])    ? number_format((float)$b['norm'], 3)    : '';
        $weight  = isset($b['weight'])  ? number_format((float)$b['weight'], 2)  : '';
        $contrib = isset($b['contrib']) ? (is_numeric($b['contrib']) ? number_format((float)$b['contrib'],3) : (string)$b['contrib']) : '';
        $rows .= "<tr><td>{$rule}</td><td style='text-align:center;'>{$value}</td><td style='text-align:center;'>{$norm}</td><td style='text-align:center;'>{$weight}</td><td style='text-align:center;'>{$contrib}</td></tr>";
    }

    $pavadinimas = htmlspecialchars($product['Pavadinimas'] ?? '-', ENT_QUOTES, 'UTF-8');
    $kategorija  = htmlspecialchars($product['Kategorija']  ?? '-', ENT_QUOTES, 'UTF-8');
    $salis       = htmlspecialchars($product['Salis']       ?? '-', ENT_QUOTES, 'UTF-8');
    $harvestDate = htmlspecialchars($product['HarvestDate'] ?? '-', ENT_QUOTES, 'UTF-8');

    $mv  = htmlspecialchars($modelMeta['version'] ?? '-', ENT_QUOTES, 'UTF-8');
    $cut = $modelMeta['cutoffs'] ?? ['ok'=>85,'review'=>25];
    $cutInfo = 'OK ≥ '.(int)$cut['ok'].', Review '.(int)$cut['review'].'–'.((int)$cut['ok']-1).', Fail < '.(int)$cut['review'];

    $html = "
    <h1>EUDR atitikties ataskaita</h1>
    <p><strong>Modelio versija:</strong> {$mv}<br><strong>Slenksčiai:</strong> {$cutInfo}</p>

    <h3>Produkto informacija</h3>
    <table border='1' cellpadding='5'>
      <tr><th>Produkto pavadinimas</th><td>{$pavadinimas}</td></tr>
      <tr><th>Kategorija</th><td>{$kategorija}</td></tr>
      <tr><th>Kilmės šalis</th><td>{$salis}</td></tr>
      <tr><th>Derliaus data</th><td>{$harvestDate}</td></tr>
    </table>
    <br/>
    <h3>Rezultatai</h3>
    <table border='1' cellpadding='5'>
      <tr><th>Atitikties balas (AB)</th><td>".number_format((float)$AB, 2)."</td></tr>
      <tr><th>Galutinė klasifikacija</th><td>".htmlspecialchars($status, ENT_QUOTES, 'UTF-8')."</td></tr>
      <tr><th>Pastabos</th><td>".htmlspecialchars($komentaras, ENT_QUOTES, 'UTF-8')."</td></tr>
    </table>
    <br/>
    <h3>Vartų ir įrodymų išskaidymas</h3>
    <table border='1' cellpadding='5'>
      <tr><th>Taisyklė / Faktorius</th><th>Reikšmė</th><th>Normalizuota</th><th>Svoris</th><th>Indėlis (±)</th></tr>
      {$rows}
    </table>
    ";

    $pdf->writeHTML($html, true, false, true, false, '');
    $relativePath = 'ataskaitos/ataskaita_' . time() . '_' . $productId . '.pdf';
    $absolutePath = __DIR__ . '/' . $relativePath;
    $pdf->Output($absolutePath, 'F');

    $stmt = $pdo->prepare("INSERT INTO ataskaita (SukurimoData, PDFNuoroda, ProduktasID, VartotojasID) VALUES (NOW(), ?, ?, ?)");
    $stmt->execute([$relativePath, $productId, $userId]);

    $_SESSION['product_message'] = "✅ Patikra atlikta. AB: ".number_format((float)$AB,2)." | Statusas: {$status}. Ataskaita sugeneruota.";
    header("Location: userdashboard.php"); exit();

} catch (Throwable $e) {
    $_SESSION['product_message'] = "❌ Klaida atliekant patikrą: " . $e->getMessage();
    header("Location: userdashboard.php"); exit();
}
