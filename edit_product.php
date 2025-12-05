<?php
require_once 'secure_session.php';
require_once 'secure_headers.php';
require 'csrf.php';
require 'db.php';

if (!isset($_SESSION['role']) || $_SESSION['role'] !== 'tiekejas') {
    header("Location: login.php"); exit();
}
if (!isset($_GET['id'])) {
    $_SESSION['product_message'] = "❌ Nenurodytas produkto ID.";
    header("Location: supplierdashboard.php"); exit();
}

$id = (int)$_GET['id'];
$tiekejas_id = (int)$_SESSION['tiekejas_id'];

$stmt = $pdo->prepare("SELECT * FROM produktas WHERE ID = ? AND TiekejasID = ?");
$stmt->execute([$id, $tiekejas_id]);
$product = $stmt->fetch(PDO::FETCH_ASSOC);
if (!$product) {
    $_SESSION['product_message'] = "❌ Produktas nerastas arba neturite prieigos.";
    header("Location: supplierdashboard.php"); exit();
}

/* NEW: pull lists from the new master tables */
$categories = $pdo->query("SELECT Kategorija FROM kategoriju_sarasas ORDER BY Kategorija ASC")->fetchAll(PDO::FETCH_COLUMN);
$countries  = $pdo->query("SELECT salis FROM saliu_sarasas ORDER BY salis ASC")->fetchAll(PDO::FETCH_COLUMN);

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $pavadinimas = trim($_POST['pavadinimas'] ?? '');
    $salis       = trim($_POST['salis'] ?? '');
    $kategorija  = trim($_POST['kategorija'] ?? '');

    $harvest     = $_POST['HarvestDate'] ?? null;
    $geoprov     = isset($_POST['GeoProvided']) ? 1 : 0;
    $legaldocs   = isset($_POST['LegalDocsProvided']) ? 1 : 0;
    $deforver    = isset($_POST['DeforestationVerified']) ? 1 : 0;
    $docscomp    = isset($_POST['DocsComplete']) ? 1 : 0;
    $decl        = isset($_POST['SupplierDeclaration']) ? 1 : 0;
    $extver      = isset($_POST['ExternalVerification']) ? 1 : 0;
    $traceDepth  = (int)($_POST['TraceabilityDepth'] ?? 0);
    $certScore   = (int)($_POST['CertScore'] ?? 0);

    $lat         = $_POST['Latitude'] ?? null;
    $lng         = $_POST['Longitude'] ?? null;
    $areaHa      = $_POST['AreaHa'] ?? null;
    $plotGeoJSON = $_POST['PlotGeoJSON'] ?? null;

    $indig       = isset($_POST['IndigenousClaims']) ? 1 : 0;
    $sanctions   = isset($_POST['SanctionsRisk']) ? 1 : 0;
    $supplyComp  = $_POST['SupplyChainComplexity'] ?? 'med';
    $mixingRisk  = $_POST['MixingRisk'] ?? 'med';
    $docRel      = $_POST['DocReliability'] ?? 'med';
    $enforce     = $_POST['LocalEnforcement'] ?? 'med';

    if ($pavadinimas && $salis && $kategorija) {
        /* NEW: no CK/GK/PK in the new schema */
        $update = $pdo->prepare("
            UPDATE produktas
            SET Pavadinimas=?, Salis=?, Kategorija=?,
                HarvestDate=?, GeoProvided=?, LegalDocsProvided=?, DeforestationVerified=?, DocsComplete=?, SupplierDeclaration=?, ExternalVerification=?,
                TraceabilityDepth=?, CertScore=?,
                Latitude=?, Longitude=?, AreaHa=?, PlotGeoJSON=?,
                IndigenousClaims=?, SanctionsRisk=?, SupplyChainComplexity=?, MixingRisk=?, DocReliability=?, LocalEnforcement=?
            WHERE ID=? AND TiekejasID=?
        ");
        $ok = $update->execute([
            $pavadinimas, $salis, $kategorija,
            ($harvest ?: null), $geoprov, $legaldocs, $deforver, $docscomp, $decl, $extver,
            max(0, min(3, $traceDepth)), max(0, min(10, $certScore)),
            ($lat !== '' ? $lat : null), ($lng !== '' ? $lng : null), ($areaHa !== '' ? $areaHa : null), ($plotGeoJSON !== '' ? $plotGeoJSON : null),
            $indig, $sanctions, $supplyComp, $mixingRisk, $docRel, $enforce,
            $id, $tiekejas_id
        ]);
        $_SESSION['product_message'] = $ok ? "✅ Produktas atnaujintas sėkmingai." : "❌ Klaida atnaujinant produktą.";
    } else {
        $_SESSION['product_message'] = "❌ Užpildykite visus privalomus laukus.";
    }
    header("Location: supplierdashboard.php"); exit();
}
?>
<!DOCTYPE html>
<html lang="lt">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Redaguoti produktą</title>
    <link rel="stylesheet" href="style.css">
    <style>
        body.forest-theme { color:#fff; }
        .page-wrap { max-width: 960px; margin: 32px auto; padding: 0 16px; }
        .card { background: rgba(255,255,255,0.96); color:#111; border-radius:14px; box-shadow:0 8px 24px rgba(0,0,0,.15); padding:20px; }
        .header-row { position:sticky; top:0; z-index:5; background:rgba(0,0,0,.35); backdrop-filter: blur(4px);
            border-radius:10px; padding:8px 12px; margin-bottom:12px; display:flex; justify-content:space-between; align-items:center; }
        .header-row a { color:#f9f871; }
        .section { margin:18px 0; }
        .section h3 { margin:0 0 10px; color:#2c3e50; }
        label { display:block; font-weight:600; margin:10px 0 6px; }
        input, select, textarea { width:100%; }
        .grid-2 { display:grid; grid-template-columns:1fr 1fr; gap:12px; }
        .check-grid { display:grid; grid-template-columns: repeat(auto-fit, minmax(260px, 1fr)); gap:10px; }
        .chk { display:flex; align-items:center; gap:8px; font-weight:600; margin:8px 0; }
        .inline { display:flex; align-items:center; gap:12px; }
        .hint { color:#666; font-size:12px; }
        .actions { display:flex; gap:10px; margin-top:16px; }
        @media (max-width: 720px) { .grid-2 { grid-template-columns:1fr; } }
    </style>
</head>
<body class="forest-theme">
<div class="page-wrap">
    <div class="header-row">
        <strong>Redaguoti produktą</strong>
        <a href="supplierdashboard.php">← Grįžti</a>
    </div>

    <form method="post" class="card">
        <!-- Pagrindinė informacija -->
        <div class="section">
            <h3>Pagrindinė informacija</h3>
            <label>Pavadinimas</label>
            <input name="pavadinimas" value="<?= htmlspecialchars($product['Pavadinimas']) ?>" required>

            <div class="grid-2">
                <div>
                    <label>Šalis</label>
                    <select name="salis" required>
                        <option value="">Pasirinkite šalį</option>
                        <?php foreach ($countries as $country): ?>
                            <option value="<?= htmlspecialchars($country) ?>" <?= $country === $product['Salis'] ? 'selected' : '' ?>>
                                <?= htmlspecialchars($country) ?>
                            </option>
                        <?php endforeach; ?>
                    </select>
                </div>
                <div>
                    <label>Kategorija</label>
                    <select name="kategorija" required>
                        <?php foreach ($categories as $cat): ?>
                            <option value="<?= htmlspecialchars($cat) ?>" <?= $cat === $product['Kategorija'] ? 'selected' : '' ?>>
                                <?= htmlspecialchars($cat) ?>
                            </option>
                        <?php endforeach; ?>
                    </select>
                </div>
            </div>

            <label>Derliaus data</label>
            <input type="date" name="HarvestDate" value="<?= htmlspecialchars($product['HarvestDate'] ?? '') ?>">
        </div>

        <!-- Geolokacija -->
        <div class="section">
            <h3>Geolokacija</h3>

            <label class="chk">
                <input type="checkbox" name="GeoProvided" <?= !empty($product['GeoProvided']) ? 'checked' : '' ?>>
                Geolokacijos duomenys pateikti
            </label>

            <label>Plotas (ha) <span class="hint">(>4 ha reikalauja poligono GeoJSON)</span></label>
            <input type="number" step="0.01" name="AreaHa" value="<?= htmlspecialchars($product['AreaHa'] ?? '') ?>">

            <div class="grid-2">
                <div>
                    <label>Platuma (≤4 ha)</label>
                    <input name="Latitude" step="0.000001" placeholder="pvz. -6.200000"
                           value="<?= htmlspecialchars($product['Latitude'] ?? '') ?>">
                </div>
                <div>
                    <label>Ilguma (≤4 ha)</label>
                    <input name="Longitude" step="0.000001" placeholder="pvz. 106.816666"
                           value="<?= htmlspecialchars($product['Longitude'] ?? '') ?>">
                </div>
            </div>

            <label>PlotGeoJSON (Polygon/MultiPolygon) (>4 ha)</label>
            <textarea name="PlotGeoJSON" placeholder='{"type":"Polygon","coordinates":[[ [lng,lat], ... , [lng,lat] ]]}' ><?= htmlspecialchars($product['PlotGeoJSON'] ?? '') ?></textarea>
        </div>

        <!-- Įrodymai -->
        <div class="section">
            <h3>Įrodymai</h3>
            <div class="check-grid">
                <label class="chk"><input type="checkbox" name="LegalDocsProvided"        <?= !empty($product['LegalDocsProvided']) ? 'checked' : '' ?>> Teisėtumo dokumentai pateikti</label>
                <label class="chk"><input type="checkbox" name="DeforestationVerified"    <?= !empty($product['DeforestationVerified']) ? 'checked' : '' ?>> Miškų nenaikinimas po 2020-12-31 patvirtintas</label>
                <label class="chk"><input type="checkbox" name="DocsComplete"             <?= !empty($product['DocsComplete']) ? 'checked' : '' ?>> Dokumentai pilni</label>
                <label class="chk"><input type="checkbox" name="SupplierDeclaration"      <?= !empty($product['SupplierDeclaration']) ? 'checked' : '' ?>> Tiekėjo deklaracija pateikta</label>
                <label class="chk"><input type="checkbox" name="ExternalVerification"     <?= !empty($product['ExternalVerification']) ? 'checked' : '' ?>> Išorinis patikrinimas atliktas</label>
            </div>

            <div class="grid-2">
                <div>
                    <label>Atsekamumo gylis (0–3)</label>
                    <input type="number" name="TraceabilityDepth" min="0" max="3" value="<?= htmlspecialchars($product['TraceabilityDepth'] ?? 0) ?>">
                </div>
                <div>
                    <label>Sertifikavimo balas (0–10)</label>
                    <input type="number" name="CertScore" min="0" max="10" value="<?= htmlspecialchars($product['CertScore'] ?? 0) ?>">
                </div>
            </div>
        </div>

        <!-- Rizikos veiksniai -->
        <div class="section">
            <h3>Rizikos veiksniai (Reglamento 10 straipsnis)</h3>
            <div class="check-grid">
                <label class="chk"><input type="checkbox" name="IndigenousClaims" <?= !empty($product['IndigenousClaims']) ? 'checked' : '' ?>> Vietinių/tautinių bendruomenių pretenzijos</label>
                <label class="chk"><input type="checkbox" name="SanctionsRisk"    <?= !empty($product['SanctionsRisk']) ? 'checked' : '' ?>> Sankcijų/korupcijos rizika</label>
            </div>
            <div class="grid-2">
                <div>
                    <label>Tiekimo grandinės sudėtingumas</label>
                    <select name="SupplyChainComplexity">
                        <?php foreach (['low','med','high'] as $opt): ?>
                            <option value="<?= $opt ?>" <?= ($product['SupplyChainComplexity'] ?? 'med') === $opt ? 'selected' : '' ?>><?= $opt ?></option>
                        <?php endforeach; ?>
                    </select>
                </div>
                <div>
                    <label>Maišymo (mixing) rizika</label>
                    <select name="MixingRisk">
                        <?php foreach (['low','med','high'] as $opt): ?>
                            <option value="<?= $opt ?>" <?= ($product['MixingRisk'] ?? 'med') === $opt ? 'selected' : '' ?>><?= $opt ?></option>
                        <?php endforeach; ?>
                    </select>
                </div>
                <div>
                    <label>Dokumentų patikimumas</label>
                    <select name="DocReliability">
                        <?php foreach (['low','med','high'] as $opt): ?>
                            <option value="<?= $opt ?>" <?= ($product['DocReliability'] ?? 'med') === $opt ? 'selected' : '' ?>><?= $opt ?></option>
                        <?php endforeach; ?>
                    </select>
                </div>
                <div>
                    <label>Vietos institucijų vykdymo užtikrinimas</label>
                    <select name="LocalEnforcement">
                        <?php foreach (['low','med','high'] as $opt): ?>
                            <option value="<?= $opt ?>" <?= ($product['LocalEnforcement'] ?? 'med') === $opt ? 'selected' : '' ?>><?= $opt ?></option>
                        <?php endforeach; ?>
                    </select>
                </div>
            </div>
        </div>

        <div class="actions">
            <button type="submit">💾 Išsaugoti</button>
            <a class="action-btn" href="supplierdashboard.php" style="text-decoration:none;display:inline-block;line-height:32px;padding:6px 10px;">Atšaukti</a>
        </div>
    </form>
</div>
</body>
</html>
