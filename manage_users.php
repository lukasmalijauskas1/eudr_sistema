<?php
require_once 'secure_session.php';
require_once 'secure_headers.php';
require 'db.php';
require 'csrf.php';

if (($_SESSION['role'] ?? '') !== 'admin') { header("Location: login.php"); exit(); }

$filters = [];
$params  = [];

if (!empty($_GET['search'])) {
    $filters[] = "(Vardas LIKE ? OR El_pastas LIKE ?)";
    $params[] = '%'.$_GET['search'].'%';
    $params[] = '%'.$_GET['search'].'%';
}
if (!empty($_GET['role'])) {
    $filters[] = "Role = ?";
    $params[] = $_GET['role'];
}
$query = "SELECT * FROM vartotojas";
if ($filters) $query .= " WHERE ".implode(" AND ", $filters);

$stmt = $pdo->prepare($query);
$stmt->execute($params);
$users = $stmt->fetchAll();

function admin_count(PDO $pdo): int {
    return (int)$pdo->query("SELECT COUNT(*) FROM vartotojas WHERE Role='admin'")->fetchColumn();
}
$adminTotal = admin_count($pdo);
$selfId     = (int)($_SESSION['user_id'] ?? 0);
?>
<!DOCTYPE html>
<html lang="lt">
<head>
    <meta charset="UTF-8">
    <title>Tvarkyti vartotojus</title>
    <link rel="stylesheet" href="style.css">
    <style>
        table{background:#fff;color:#000;border-collapse:collapse;width:100%}
        th,td{padding:6px;border:1px solid #ccc}
        .action-btn{background:#4CAF50;color:#fff;padding:5px 10px;text-decoration:none;border:none;cursor:pointer}
    </style>
</head>
<body>
<div class="container">
    <h2>Vartotojų sąrašas</h2>
	<?php if (!empty($_SESSION['login_error'])): ?>
  <p class="error"><?= htmlspecialchars($_SESSION['login_error']) ?></p>
  <?php unset($_SESSION['login_error']); ?>
<?php endif; ?>
<?php if (!empty($_SESSION['flash_success'])): ?>
  <p class="success"><?= htmlspecialchars($_SESSION['flash_success']) ?></p>
  <?php unset($_SESSION['flash_success']); ?>
<?php endif; ?>


    <a href="add_user.php" class="action-btn">➕ Pridėti vartotoją</a>

    <form method="get" style="margin:10px 0 15px">
        <input type="text" name="search" placeholder="Ieškoti vardo arba el. pašto" value="<?= htmlspecialchars($_GET['search'] ?? '') ?>">
        <select name="role">
            <option value="">Visos rolės</option>
            <option value="naudotojas"   <?= (($_GET['role']??'')==='naudotojas')?'selected':'' ?>>Naudotojas</option>
            <option value="inspektorius" <?= (($_GET['role']??'')==='inspektorius')?'selected':'' ?>>Inspektorius</option>
            <option value="admin"        <?= (($_GET['role']??'')==='admin')?'selected':'' ?>>Administratorius</option>
        </select>
        <button type="submit" class="action-btn">🔍 Filtruoti</button>
    </form>

    <table>
        <tr><th>Vardas</th><th>El. paštas</th><th>Rolė</th><th>Veiksmai</th></tr>
        <?php foreach ($users as $u): ?>
            <tr>
                <td><?= htmlspecialchars($u['Vardas']) ?></td>
                <td><?= htmlspecialchars($u['El_pastas']) ?></td>
                <td><?= htmlspecialchars($u['Role']) ?></td>
                <td>
                    <a href="edit_user.php?id=<?= $u['ID'] ?>">✏️</a>
                    <?php
                    $canDelete = true;
                    if ($u['ID'] == $selfId) $canDelete = false; // don't self-delete
                    if ($u['Role'] === 'admin' && $adminTotal <= 1) $canDelete = false; // keep at least 1 admin
                    ?>
                    <?php if ($canDelete): ?>
                    <form method="post" action="delete_user.php" style="display:inline" onsubmit="return confirm('Ar tikrai norite ištrinti?');">
                        <?= csrf_field() ?>
                        <input type="hidden" name="id" value="<?= $u['ID'] ?>">
                        <button type="submit" class="action-btn">🗑️</button>
                    </form>
                    <?php endif; ?>
                </td>
            </tr>
        <?php endforeach; ?>
    </table>

    <br><a href="admindashboard.php">Grįžti į skydelį</a>
</div>
</body>
</html>
