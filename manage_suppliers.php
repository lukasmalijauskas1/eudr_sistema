<?php
require_once 'secure_session.php';
require_once 'secure_headers.php';
require 'db.php';
require 'csrf.php';

if (($_SESSION['role'] ?? '') !== 'admin') { header("Location: login.php"); exit(); }

$query = "SELECT * FROM tiekejas";
$params = [];
if (!empty($_GET['search'])) {
    $query .= " WHERE Pavadinimas LIKE ? OR Adresas LIKE ? OR Kontaktai LIKE ?";
    $search = '%'.$_GET['search'].'%';
    $params = [$search,$search,$search];
}
$stmt = $pdo->prepare($query);
$stmt->execute($params);
$suppliers = $stmt->fetchAll();
?>
<!DOCTYPE html>
<html lang="lt">
<head>
    <meta charset="UTF-8"><title>Tiekėjai</title>
    <link rel="stylesheet" href="style.css">
    <style>table{background:#fff;color:#000;border-collapse:collapse;width:100%} th,td{padding:6px;border:1px solid #ccc} .action-btn{background:#4CAF50;color:#fff;padding:5px 10px;text-decoration:none;border:none;cursor:pointer}</style>
</head>
<body>
<div class="container">
    <h2>Tiekėjų sąrašas</h2>
	<?php if (!empty($_SESSION['login_error'])): ?>
  <p class="error"><?= htmlspecialchars($_SESSION['login_error']) ?></p>
  <?php unset($_SESSION['login_error']); ?>
<?php endif; ?>
<?php if (!empty($_SESSION['flash_success'])): ?>
  <p class="success"><?= htmlspecialchars($_SESSION['flash_success']) ?></p>
  <?php unset($_SESSION['flash_success']); ?>
<?php endif; ?>

    <a href="add_supplier.php" class="action-btn">➕ Pridėti tiekėją</a>
    <form method="get" style="margin-top:10px;margin-bottom:15px;">
        <input type="text" name="search" placeholder="Ieškoti pavadinimo, adreso ar kontaktų" value="<?= htmlspecialchars($_GET['search'] ?? '') ?>">
        <button type="submit" class="action-btn">🔍 Filtruoti</button>
    </form>

    <table>
        <tr><th>Pavadinimas</th><th>Adresas</th><th>Kontaktai</th><th>Veiksmai</th></tr>
        <?php foreach ($suppliers as $s): ?>
            <tr>
                <td><?= htmlspecialchars($s['Pavadinimas']) ?></td>
                <td><?= htmlspecialchars($s['Adresas']) ?></td>
                <td><?= htmlspecialchars($s['Kontaktai']) ?></td>
                <td>
                    <a href="edit_supplier.php?id=<?= $s['ID'] ?>">✏️</a>
                    <form method="post" action="delete_suppliers.php" style="display:inline" onsubmit="return confirm('Ar tikrai norite ištrinti?');">
                        <?= csrf_field() ?>
                        <input type="hidden" name="id" value="<?= $s['ID'] ?>">
                        <button type="submit" class="action-btn">🗑️</button>
                    </form>
                </td>
            </tr>
        <?php endforeach; ?>
    </table>

    <br><a href="admindashboard.php">Grįžti į skydelį</a>
</div>
</body>
</html>
