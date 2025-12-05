<?php
require_once 'secure_session.php';
require_once 'secure_headers.php';
require_once 'csrf.php';
require 'db.php';

if (!isset($_SESSION['role']) || $_SESSION['role'] !== 'tiekejas') {
    header("Location: login.php"); exit();
}

$tiekejas_id   = (int)($_SESSION['tiekejas_id'] ?? 0);
$supplier_name = (string)($_SESSION['supplier_name'] ?? '');
$message = $_SESSION['product_message'] ?? "";
unset($_SESSION['product_message']);

/* --- Master lists --- */
$categories = $pdo->query("SELECT Kategorija FROM kategoriju_sarasas ORDER BY Kategorija")->fetchAll(PDO::FETCH_COLUMN);
$countries  = $pdo->query("SELECT salis FROM saliu_sarasas ORDER BY salis")->fetchAll(PDO::FETCH_COLUMN);

/* --- Add product --- */
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['add_product'])) {
    if (!csrf_validate($_POST['csrf_token'] ?? '')) {
        $message = "❌ Netinkama užklausa.";
    } else {
        $pavadinimas = trim($_POST['pavadinimas'] ?? '');
        $salis       = trim($_POST['salis'] ?? '');
        $kategorija  = trim($_POST['kategorija'] ?? '');

        if ($pavadinimas === '' || $salis === '' || $kategorija === '') {
            $message = "❌ Užpildykite visus laukus.";
        } else {
            $okC = $pdo->prepare("SELECT 1 FROM saliu_sarasas WHERE salis=?");
            $okC->execute([$salis]);
            $okK = $pdo->prepare("SELECT 1 FROM kategoriju_sarasas WHERE Kategorija=?");
            $okK->execute([$kategorija]);

            if ($okC->fetchColumn() && $okK->fetchColumn()) {
                $ins = $pdo->prepare("INSERT INTO produktas (Pavadinimas, Salis, Kategorija, TiekejasID) VALUES (?, ?, ?, ?)");
                if ($ins->execute([$pavadinimas, $salis, $kategorija, $tiekejas_id])) {
                    $message = "✅ Produktas pridėtas sėkmingai.";
                } else {
                    $message = "❌ Nepavyko pridėti produkto.";
                }
            } else {
                $message = "❌ Nežinoma šalis arba kategorija.";
            }
        }
    }
}

/* --- List products (with filters) --- */
$query  = "SELECT ID, Pavadinimas, Salis, Kategorija FROM produktas WHERE TiekejasID = ?";
$params = [$tiekejas_id];

if (!empty($_GET['search']))         { $query .= " AND Pavadinimas LIKE ?"; $params[] = '%'.$_GET['search'].'%'; }
if (!empty($_GET['filter_salis']))    { $query .= " AND Salis = ?";           $params[] = $_GET['filter_salis']; }
if (!empty($_GET['filter_kategorija'])){ $query .= " AND Kategorija = ?";     $params[] = $_GET['filter_kategorija']; }

$stmt = $pdo->prepare($query);
$stmt->execute($params);
$products = $stmt->fetchAll(PDO::FETCH_ASSOC);
?>
<!DOCTYPE html>
<html lang="lt">
<head>
<meta charset="UTF-8">
<title>Tiekėjo skydelis</title>
<link rel="stylesheet" href="style.css">
<style>
  .product-wrap {
      max-height: 520px;
      overflow-y: auto;
      background: white;
      border-radius: 8px;
      box-shadow: 0 2px 8px rgba(0,0,0,.08);
  }
  .product-table { width:100%; border-collapse: collapse; color:#111; background: transparent; }
  .product-table th, .product-table td { border-bottom:1px solid #e6e6e6; padding:10px 12px; white-space:nowrap; }
  .product-table thead th { position: sticky; top:0; background:#f8f9fa; z-index:2; }
  .action-btn { background:#4CAF50; color:#fff; border:none; padding:6px 10px; cursor:pointer; }
  .action-btn:hover { background:#45a049; }
</style>
</head>
<body class="forest-theme">
<div class="container">
  <h2>Sveiki, <?= htmlspecialchars($supplier_name) ?></h2>

  <?php if ($message): ?>
    <p class="<?= str_contains($message,'❌') ? 'error' : 'success' ?>"><?= $message ?></p>
  <?php endif; ?>

  <h3>Pridėti naują produktą</h3>
  <form method="post">
    <?= csrf_field() ?>
    <input name="pavadinimas" placeholder="Produkto pavadinimas" required>
    <select name="salis" required>
      <option value="">Pasirinkite šalį</option>
      <?php foreach ($countries as $code): ?>
        <option value="<?= htmlspecialchars($code) ?>"><?= htmlspecialchars($code) ?></option>
      <?php endforeach; ?>
    </select>
    <select name="kategorija" required>
      <option value="">Pasirinkite kategoriją</option>
      <?php foreach ($categories as $cat): ?>
        <option value="<?= htmlspecialchars($cat) ?>"><?= htmlspecialchars($cat) ?></option>
      <?php endforeach; ?>
    </select>
    <button type="submit" name="add_product" class="action-btn">Pridėti</button>
  </form>

  <h3>Jūsų produktai</h3>
  <form method="get" style="margin:10px 0;">
    <input type="text" name="search" placeholder="Ieškoti pavadinimo" value="<?= htmlspecialchars($_GET['search'] ?? '') ?>">
    <select name="filter_salis">
      <option value="">Visos šalys</option>
      <?php foreach ($countries as $code): ?>
        <option value="<?= $code ?>" <?= (($_GET['filter_salis'] ?? '') === $code) ? 'selected' : '' ?>><?= $code ?></option>
      <?php endforeach; ?>
    </select>
    <select name="filter_kategorija">
      <option value="">Visos kategorijos</option>
      <?php foreach ($categories as $cat): ?>
        <option value="<?= $cat ?>" <?= (($_GET['filter_kategorija'] ?? '') === $cat) ? 'selected' : '' ?>><?= $cat ?></option>
      <?php endforeach; ?>
    </select>
    <button type="submit" class="action-btn">🔍 Filtruoti</button>
  </form>

  <?php if ($products): ?>
    <div class="product-wrap">
      <table class="product-table">
        <thead>
          <tr>
            <th>Pavadinimas</th>
            <th>Šalis</th>
            <th>Kategorija</th>
            <th>Veiksmai</th>
          </tr>
        </thead>
        <tbody>
          <?php foreach ($products as $p): ?>
            <tr>
              <td><?= htmlspecialchars($p['Pavadinimas']) ?></td>
              <td><?= htmlspecialchars($p['Salis']) ?></td>
              <td><?= htmlspecialchars($p['Kategorija']) ?></td>
              <td>
                <a href="edit_product.php?id=<?= (int)$p['ID'] ?>">✏️</a>
                <form method="post" action="delete_product.php" style="display:inline" onsubmit="return confirm('Ar tikrai ištrinti šį produktą?');">
                  <?= csrf_field() ?>
                  <input type="hidden" name="id" value="<?= (int)$p['ID'] ?>">
                  <button type="submit" class="action-btn">🗑️</button>
                </form>
              </td>
            </tr>
          <?php endforeach; ?>
        </tbody>
      </table>
    </div>
  <?php else: ?>
    <p>Neturite pridėtų produktų.</p>
  <?php endif; ?>

  <br><a href="logout.php">Atsijungti</a>
</div>
</body>
</html>
