<?php
require_once 'secure_session.php';
require_once 'secure_headers.php';
require_once 'db.php';
require_once 'tcpdf/tcpdf.php';
require_once 'csrf.php';
require_once 'risk_engine_v2.php'; // to reuse MODEL_VERSION for provenance

if ($_SERVER['REQUEST_METHOD'] !== 'POST' || !csrf_validate($_POST['csrf_token'] ?? '')) {
    $_SESSION['product_message'] = "❌ Netinkama užklausa.";
    header("Location: userdashboard.php"); exit();
}
if (!isset($_SESSION['user_id']) || ($_SESSION['role'] ?? '') !== 'naudotojas') {
    $_SESSION['product_message'] = "❌ Prieiga negalima.";
    header("Location: login.php"); exit();
}

$productId = (int)($_POST['product_id'] ?? 0);
if ($productId <= 0) { $_SESSION['product_message'] = "❌ Trūksta produkto ID."; header("Location: userdashboard.php"); exit(); }
$userId = (int)$_SESSION['user_id'];

try {
    $stmt = $pdo->prepare("
        SELECT p.*, t.Pavadinimas AS SupplierName, t.ID AS SupplierID
        FROM produktas p
        LEFT JOIN tiekejas t ON t.ID = p.TiekejasID
        WHERE p.ID = ?
    ");
    $stmt->execute([$productId]);
    $p = $stmt->fetch(PDO::FETCH_ASSOC);
    if (!$p) throw new RuntimeException("Produktas nerastas.");

    // latest AB/status for the summary
    $stmt = $pdo->prepare("SELECT AB, Statusas FROM atitiktiespatikra WHERE ProduktasID = ? ORDER BY ID DESC LIMIT 1");
    $stmt->execute([$productId]);
    $latest = $stmt->fetch(PDO::FETCH_ASSOC);
    $ab     = $latest['AB'] ?? null;
    $status = $latest['Statusas'] ?? null;

    // provenance metadata (same as risk engine constants)
    $modelMeta = [
        'version' => defined('MODEL_VERSION') ? MODEL_VERSION : 'v2.0',
        'cutoffs' => ['ok'=>85,'review'=>25]
    ];
    $modelJson = json_encode($modelMeta, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);

    // JSON payload snapshot
    $payload = [
        'product' => [
            'id'            => $p['ID'],
            'name'          => $p['Pavadinimas'],
            'category'      => $p['Kategorija'],
            'country'       => $p['Salis'],
            'harvest_date'  => $p['HarvestDate'] ?? null,
        ],
        'supplier' => [
            'id'   => $p['SupplierID'] ?? null,
            'name' => $p['SupplierName'] ?? null,
        ],
        'geolocation' => [
            'area_ha'                 => $p['AreaHa'],
            'lat'                     => $p['Latitude'],
            'lng'                     => $p['Longitude'],
            'polygon_geojson_present' => !empty($p['PlotGeoJSON']),
        ],
        'evidence' => [
            'geo_provided'           => (int)$p['GeoProvided'] === 1,
            'legal_docs'             => (int)$p['LegalDocsProvided'] === 1,
            'deforestation_verified' => (int)$p['DeforestationVerified'] === 1,
            'docs_complete'          => (int)$p['DocsComplete'] === 1,
            'supplier_declaration'   => (int)$p['SupplierDeclaration'] === 1,
            'external_verification'  => (int)$p['ExternalVerification'] === 1,
            'traceability_depth'     => (int)($p['TraceabilityDepth'] ?? 0),
            'cert_score_0_10'        => (int)($p['CertScore'] ?? 0),
        ],
        'art10_factors' => [
            'indigenous_claims'       => (int)$p['IndigenousClaims'] === 1,
            'sanctions_risk'          => (int)$p['SanctionsRisk'] === 1,
            'supply_chain_complexity' => $p['SupplyChainComplexity'] ?? 'med',
            'mixing_risk'             => $p['MixingRisk'] ?? 'med',
            'doc_reliability'         => $p['DocReliability'] ?? 'med',
            'local_enforcement'       => $p['LocalEnforcement'] ?? 'med',
        ],
        'latest_check' => [
            'ab'     => $ab,
            'status' => $status,
        ],
        'model'             => $modelMeta,
        'prepared_by_user'  => $userId,
        'prepared_at'       => date('c')
    ];
    $json = json_encode($payload, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES | JSON_PRETTY_PRINT);

    // INSERT DDS with model metadata
    $stmt = $pdo->prepare("INSERT INTO dd_statement
      (ProduktasID, VartotojasID, JSONPayload, Status, SukurimoData, ModelVersion, ModelConfig)
      VALUES (?, ?, ?, 'Prepared', NOW(), ?, ?)");
    $stmt->execute([$productId, $userId, $json, $modelMeta['version'], $modelJson]);
    $ddsId = (int)$pdo->lastInsertId();

    // PDF path
    $reportsDir = __DIR__ . '/ataskaitos';
    if (!is_dir($reportsDir)) @mkdir($reportsDir, 0775, true);
    $fileRel = "ataskaitos/dds_{$ddsId}_{$productId}.pdf";
    $fileAbs = __DIR__ . '/' . $fileRel;

    // ----- Build PDF -----
    $pdf = new TCPDF();
    $pdf->SetAutoPageBreak(true, 15);
    $pdf->setCellHeightRatio(1.1);
    $pdf->SetFont('dejavusans', '', 9);
    $pdf->AddPage();

    $html = '
    <h1>Due Diligence Statement (EUDR)</h1>
    <p><strong>Modelio versija:</strong> '.htmlspecialchars($modelMeta['version'],ENT_QUOTES,'UTF-8').'</p>

    <h3>Produktas</h3>
    <table border="1" cellpadding="5">
      <tr><th>Pavadinimas</th><td>'.htmlspecialchars($p['Pavadinimas'] ?? '-', ENT_QUOTES, 'UTF-8').'</td></tr>
      <tr><th>Kategorija</th><td>'.htmlspecialchars($p['Kategorija'] ?? '-', ENT_QUOTES, 'UTF-8').'</td></tr>
      <tr><th>Šalis</th><td>'.htmlspecialchars($p['Salis'] ?? '-', ENT_QUOTES, 'UTF-8').'</td></tr>
      <tr><th>Derliaus data</th><td>'.htmlspecialchars($p['HarvestDate'] ?? '-', ENT_QUOTES, 'UTF-8').'</td></tr>
    </table>

    <h3>Tiekėjas</h3>
    <table border="1" cellpadding="5">
      <tr><th>Pavadinimas</th><td>'.htmlspecialchars($p['SupplierName'] ?? '-', ENT_QUOTES, 'UTF-8').'</td></tr>
      <tr><th>ID</th><td>'.htmlspecialchars($p['SupplierID'] ?? '-', ENT_QUOTES, 'UTF-8').'</td></tr>
    </table>

    <h3>Geolokacija</h3>
    <table border="1" cellpadding="5">
      <tr><th>Plotas (ha)</th><td>'.htmlspecialchars($p['AreaHa'] ?? '-', ENT_QUOTES, 'UTF-8').'</td></tr>
      <tr><th>Lat/Lng</th><td>'.htmlspecialchars(($p['Latitude'] ?? "-").", ".($p['Longitude'] ?? "-"), ENT_QUOTES, "UTF-8").'</td></tr>
      <tr><th>Poligonas (GeoJSON)</th><td>'.(!empty($p['PlotGeoJSON']) ? 'Taip' : 'Ne').'</td></tr>
    </table>

    <h3>Įrodymai</h3>
    <table border="1" cellpadding="5">
      <tr><th>GeoProvided</th><td>'.(((int)$p['GeoProvided']) ? 'Taip' : 'Ne').'</td></tr>
      <tr><th>LegalDocsProvided</th><td>'.(((int)$p['LegalDocsProvided']) ? 'Taip' : 'Ne').'</td></tr>
      <tr><th>DeforestationVerified</th><td>'.(((int)$p['DeforestationVerified']) ? 'Taip' : 'Ne').'</td></tr>
      <tr><th>DocsComplete</th><td>'.(((int)$p['DocsComplete']) ? 'Taip' : 'Ne').'</td></tr>
      <tr><th>SupplierDeclaration</th><td>'.(((int)$p['SupplierDeclaration']) ? 'Taip' : 'Ne').'</td></tr>
      <tr><th>ExternalVerification</th><td>'.(((int)$p['ExternalVerification']) ? 'Taip' : 'Ne').'</td></tr>
      <tr><th>TraceabilityDepth</th><td>'.htmlspecialchars($p['TraceabilityDepth'] ?? '0', ENT_QUOTES, 'UTF-8').'</td></tr>
      <tr><th>CertScore</th><td>'.htmlspecialchars($p['CertScore'] ?? '0', ENT_QUOTES, 'UTF-8').'</td></tr>
    </table>

    <div nobr="true">
      <h3>Patikros suvestinė</h3>
      <table border="1" cellpadding="5">
        <tr><th>Paskutinis AB</th><td>'.htmlspecialchars($ab ?? '-', ENT_QUOTES, 'UTF-8').'</td></tr>
        <tr><th>Statusas</th><td>'.htmlspecialchars($status ?? '-', ENT_QUOTES, 'UTF-8').'</td></tr>
      </table>
    </div>
    ';

    $pdf->writeHTML($html, true, false, true, false, '');
    $pdf->Output($fileAbs, 'F');

    // store file path
    $stmt = $pdo->prepare("UPDATE dd_statement SET PDFNuoroda=? WHERE ID=?");
    $stmt->execute([$fileRel, $ddsId]);

    $_SESSION['product_message'] = "✅ Due Diligence Statement parengtas.";
    header("Location: userdashboard.php"); exit();

} catch (Throwable $e) {
    $_SESSION['product_message'] = "❌ Klaida generuojant DDS: " . $e->getMessage();
    header("Location: userdashboard.php"); exit();
}
