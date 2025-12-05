<?php
require_once 'secure_session.php';
require_once 'secure_headers.php';
require_once 'csrf.php';
require 'db.php';

if (!isset($_SESSION['user_id']) || $_SESSION['role'] !== 'naudotojas') {
    header("Location: login.php"); exit();
}

$user_id = (int)$_SESSION['user_id'];
$stmt = $pdo->prepare("SELECT Vardas FROM vartotojas WHERE ID = ?");
$stmt->execute([$user_id]);
$user_name = $stmt->fetchColumn();

/* ---- Filter options (master lists) ---- */
$categories = $pdo->query("SELECT Kategorija FROM kategoriju_sarasas ORDER BY Kategorija")->fetchAll(PDO::FETCH_COLUMN);
$countries  = $pdo->query("SELECT salis FROM saliu_sarasas ORDER BY salis")->fetchAll(PDO::FETCH_COLUMN);
$tiekejai   = $pdo->query("SELECT ID, Pavadinimas FROM tiekejas ORDER BY Pavadinimas")->fetchAll(PDO::FETCH_ASSOC);

/* ---------- PRODUCTS (with filters) ---------- */
$pq = "
    SELECT p.ID, p.Pavadinimas, p.Salis AS KilmesSalis, p.Kategorija,
           t.Pavadinimas AS TiekejasVardas, t.ID AS TiekejasID
    FROM produktas p
    LEFT JOIN tiekejas t ON p.TiekejasID = t.ID
    WHERE 1=1
";
$pp = [];
if (!empty($_GET['search']))     { $pq .= " AND p.Pavadinimas LIKE ?"; $pp[] = '%'.$_GET['search'].'%'; }
if (!empty($_GET['salis']))      { $pq .= " AND p.Salis = ?";          $pp[] = $_GET['salis']; }
if (!empty($_GET['kategorija'])) { $pq .= " AND p.Kategorija = ?";     $pp[] = $_GET['kategorija']; }
if (!empty($_GET['tiekejas']))   { $pq .= " AND t.ID = ?";             $pp[] = $_GET['tiekejas']; }
$stmt = $pdo->prepare($pq); $stmt->execute($pp); $products = $stmt->fetchAll(PDO::FETCH_ASSOC);

/* ---------- REPORTS (ATASKAITOS) ---------- */
$r_from = trim($_GET['r_from'] ?? '');
$r_to   = trim($_GET['r_to']   ?? '');
$rq = "SELECT * FROM ataskaita WHERE VartotojasID = ? ";
$rp = [$user_id];
if ($r_from !== '') { $rq .= " AND SukurimoData >= ?"; $rp[] = $r_from.(strlen($r_from)===10 ? " 00:00:00" : ""); }
if ($r_to   !== '') { $rq .= " AND SukurimoData <= ?"; $rp[] = $r_to  .(strlen($r_to)===10   ? " 23:59:59" : ""); }
$rq .= " ORDER BY SukurimoData DESC";
$stmt = $pdo->prepare($rq); $stmt->execute($rp); $userReports = $stmt->fetchAll(PDO::FETCH_ASSOC);

/* ---------- DDS (no status filter) ---------- */
$dds_from = trim($_GET['dds_from'] ?? '');
$dds_to   = trim($_GET['dds_to']   ?? '');
$dds = [];
if ($pdo->query("SHOW TABLES LIKE 'dd_statement'")->rowCount() > 0) {
    $dq = "SELECT * FROM dd_statement WHERE VartotojasID = ? ";
    $dp = [$user_id];
    if ($dds_from !== '') { $dq .= " AND SukurimoData >= ?"; $dp[] = $dds_from.(strlen($dds_from)===10 ? " 00:00:00" : ""); }
    if ($dds_to   !== '') { $dq .= " AND SukurimoData <= ?"; $dp[] = $dds_to  .(strlen($dds_to)===10   ? " 23:59:59" : ""); }
    $dq .= " ORDER BY SukurimoData DESC";
    $stmt = $pdo->prepare($dq); $stmt->execute($dp); $dds = $stmt->fetchAll(PDO::FETCH_ASSOC);
}

/* helper: translate DDS status for display */
function dds_status_lt(?string $s): string {
    if (!$s) return '-';
    return match (strtolower($s)) {
        'prepared'  => 'Parengta',
        'submitted' => 'Pateikta',
        'prepared*' => 'Parengta',
        default     => $s,
    };
}
?>
<!DOCTYPE html>
<html lang="lt">
<head>
<meta charset="UTF-8">
<title>Naudotojo skydelis</title>
<link rel="stylesheet" href="style.css">
<style>
  /* ---------- Tables & messages ---------- */
  .product-table { color:#111; background:#fff; border-collapse:collapse; width:100%; }
  .product-table th, .product-table td { border:1px solid #ccc; padding:8px; }
  .product-table th { background:#f2f2f2; }
  .table-wrap{ max-height:420px; overflow:auto; border:1px solid #ddd; border-radius:6px; }
  .product-table thead th{ position:sticky; top:0; z-index:2; box-shadow:0 1px 0 #ccc; }
  .action-btn{ background:#4CAF50; border:none; color:#fff; padding:6px 10px; cursor:pointer; }
  .action-btn:hover{ background:#45a049; }
  .message{ font-weight:bold; padding:10px; margin-top:10px; }
  .message.success{ color:green; } .message.error{ color:red; }
  form[action="import_csv.php"] input[type="file"] { color:black; }
  form[action="import_csv.php"] input[type="file"]::-webkit-file-upload-button { color:black; }

  /* ---------- Filter bars (unified) ---------- */
  .filter-row {
    display:grid;
    grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
    gap: 10px 12px;
    align-items:end;
    margin:10px 0 12px;
    max-width:100%;
  }
  .filter-row input,
  .filter-row select,
  .filter-row button {
    width:100% !important;
    max-width:100% !important;
    box-sizing:border-box;
  }
  .filter-card {
    background:rgba(255,255,255,.92);
    border-radius:10px;
    padding:12px;
    color:#111;
  }
  .filter-field label {
    display:block;
    font-weight:600;
    margin-bottom:6px;
    color:#2c3e50;
  }
  @media (min-width:560px){ .filter-row button{ width:auto !important; } }

  /* Products filter gets slightly wider columns */
  .products-filter .filter-row{ grid-template-columns: repeat(auto-fit, minmax(220px,1fr)); }
</style>
</head>
<body class="forest-theme">
<div class="container">
  <h2>Sveiki, <?= htmlspecialchars($user_name) ?></h2>

  <?php if (isset($_SESSION['product_message'])): $msg=$_SESSION['product_message']; unset($_SESSION['product_message']); ?>
    <div class="message <?= str_contains($msg,'❌')?'error':'success' ?>"><?= $msg ?></div>
  <?php endif; ?>

  <form method="post" action="export_csv.php" style="display:inline;">
    <?= csrf_field() ?><button type="submit" class="action-btn">📄 Eksportuoti į CSV</button>
  </form>
  <form method="post" action="export_pdf.php" style="display:inline;">
    <?= csrf_field() ?><button type="submit" class="action-btn">📑 Eksportuoti į PDF</button>
  </form>

  <h3>Importuoti produktus iš CSV</h3>
  <form method="post" action="import_csv.php" enctype="multipart/form-data" style="margin-bottom:20px;">
    <?= csrf_field() ?>
    <input type="file" name="csv_file" accept=".csv" required>
    <button type="submit" class="action-btn">📥 Importuoti CSV</button>
  </form>

  <!-- ===================== PRODUCTS ===================== -->
  <h3>Produktų sąrašas</h3>
  <form method="get" class="products-filter">
    <div class="filter-row filter-card">
      <input type="text" name="search" placeholder="Ieškoti pavadinimo" value="<?= htmlspecialchars($_GET['search'] ?? '') ?>">
      <select name="salis">
        <option value="">Visos šalys</option>
        <?php foreach($countries as $s): ?>
          <option value="<?= $s ?>" <?= (($_GET['salis']??'')===$s)?'selected':'' ?>><?= $s ?></option>
        <?php endforeach; ?>
      </select>
      <select name="kategorija">
        <option value="">Visos kategorijos</option>
        <?php foreach($categories as $k): ?>
          <option value="<?= $k ?>" <?= (($_GET['kategorija']??'')===$k)?'selected':'' ?>><?= $k ?></option>
        <?php endforeach; ?>
      </select>
      <select name="tiekejas">
        <option value="">Visi tiekėjai</option>
        <?php foreach($tiekejai as $t): ?>
          <option value="<?= $t['ID'] ?>" <?= (($_GET['tiekejas']??'')==$t['ID'])?'selected':'' ?>><?= htmlspecialchars($t['Pavadinimas']) ?></option>
        <?php endforeach; ?>
      </select>
      <button type="submit" class="action-btn">🔍 Filtruoti</button>
    </div>
  </form>

  <?php if ($products): ?>
    <div class="table-wrap">
      <table class="product-table">
        <thead><tr><th>Pavadinimas</th><th>Kilmės šalis</th><th>Kategorija</th><th>Tiekėjas</th><th>Veiksmai</th></tr></thead>
        <tbody>
        <?php foreach ($products as $pr): ?>
          <tr>
            <td><?= htmlspecialchars($pr['Pavadinimas']) ?></td>
            <td><?= htmlspecialchars($pr['KilmesSalis']) ?></td>
            <td><?= htmlspecialchars($pr['Kategorija']) ?></td>
            <td><?= htmlspecialchars($pr['TiekejasVardas'] ?? 'Nenurodytas') ?></td>
            <td>
              <form method="post" action="eudr_check.php" style="display:inline;">
                <?= csrf_field() ?><input type="hidden" name="product_id" value="<?= (int)$pr['ID'] ?>">
                <button type="submit" class="action-btn">🔍 Tikrinti atitiktį</button>
              </form>
              <form method="post" action="dds_generate.php" style="display:inline;margin-left:6px;">
                <?= csrf_field() ?><input type="hidden" name="product_id" value="<?= (int)$pr['ID'] ?>">
                <button type="submit" class="action-btn">🧾 Generuoti DDS</button>
              </form>
            </td>
          </tr>
        <?php endforeach; ?>
        </tbody>
      </table>
    </div>
  <?php else: ?>
    <p>Nėra įrašytų produktų.</p>
  <?php endif; ?>

  <!-- ===================== REPORTS ===================== -->
  <h3>Jūsų ataskaitos</h3>
  <form method="get">
    <!-- keep product filters in URL -->
    <input type="hidden" name="search"     value="<?= htmlspecialchars($_GET['search'] ?? '') ?>">
    <input type="hidden" name="salis"      value="<?= htmlspecialchars($_GET['salis'] ?? '') ?>">
    <input type="hidden" name="kategorija" value="<?= htmlspecialchars($_GET['kategorija'] ?? '') ?>">
    <input type="hidden" name="tiekejas"   value="<?= htmlspecialchars($_GET['tiekejas'] ?? '') ?>">

    <div class="filter-row filter-card">
      <div class="filter-field">
        <label>Nuo</label>
        <input type="date" name="r_from" value="<?= htmlspecialchars($r_from) ?>">
      </div>
      <div class="filter-field">
        <label>Iki</label>
        <input type="date" name="r_to" value="<?= htmlspecialchars($r_to) ?>">
      </div>
      <button type="submit" class="action-btn">🔎 Filtruoti ataskaitas</button>
    </div>
  </form>

  <?php if ($userReports): ?>
    <div class="table-wrap">
      <table class="product-table">
        <thead><tr><th>Sukurta</th><th>PDF</th></tr></thead>
        <tbody>
        <?php foreach ($userReports as $r): $file = basename($r['PDFNuoroda']); ?>
          <tr>
            <td><?= htmlspecialchars(date('Y-m-d H:i:s', strtotime($r['SukurimoData']))) ?></td>
            <td><a href="download_report.php?file=<?= urlencode($file) ?>" class="action-btn">📄 Peržiūrėti</a></td>
          </tr>
        <?php endforeach; ?>
        </tbody>
      </table>
    </div>
  <?php else: ?>
    <p>Neturite ataskaitų.</p>
  <?php endif; ?>

  <!-- ===================== DDS ===================== -->
  <?php if ($dds): ?>
    <h3>Jūsų Due Diligence Statements</h3>
    <form method="get">
      <!-- echo other filters again -->
      <input type="hidden" name="search"     value="<?= htmlspecialchars($_GET['search'] ?? '') ?>">
      <input type="hidden" name="salis"      value="<?= htmlspecialchars($_GET['salis'] ?? '') ?>">
      <input type="hidden" name="kategorija" value="<?= htmlspecialchars($_GET['kategorija'] ?? '') ?>">
      <input type="hidden" name="tiekejas"   value="<?= htmlspecialchars($_GET['tiekejas'] ?? '') ?>">
      <input type="hidden" name="r_from"     value="<?= htmlspecialchars($r_from) ?>">
      <input type="hidden" name="r_to"       value="<?= htmlspecialchars($r_to) ?>">

      <div class="filter-row filter-card">
        <div class="filter-field">
          <label>Nuo</label>
          <input type="date" name="dds_from" value="<?= htmlspecialchars($dds_from) ?>">
        </div>
        <div class="filter-field">
          <label>Iki</label>
          <input type="date" name="dds_to" value="<?= htmlspecialchars($dds_to) ?>">
        </div>
        <button type="submit" class="action-btn">🔎 Filtruoti DDS</button>
      </div>
    </form>

    <div class="table-wrap">
      <table class="product-table">
        <thead><tr><th>Sukurta</th><th>Statusas</th><th>PDF</th></tr></thead>
        <tbody>
        <?php foreach ($dds as $d): ?>
          <tr>
            <td><?= htmlspecialchars($d['SukurimoData']) ?></td>
            <td><?= htmlspecialchars(dds_status_lt($d['Status'])) ?></td>
            <td>
              <?php if (!empty($d['PDFNuoroda'])): $f = basename($d['PDFNuoroda']); ?>
                <a href="download_report.php?file=<?= urlencode($f) ?>" class="action-btn">🧾 Atsisiųsti</a>
              <?php else: ?>-<?php endif; ?>
            </td>
          </tr>
        <?php endforeach; ?>
        </tbody>
      </table>
    </div>
  <?php endif; ?>

  <br><a href="logout.php">Atsijungti</a>
</div>
</body>
</html>