<?php
require_once 'secure_session.php';
require_once 'secure_headers.php';
require 'db.php';
require 'csrf.php';

if (($_SESSION['role'] ?? '') !== 'admin') { header("Location: login.php"); exit(); }

$message = "";
if (!isset($_GET['id'])) { $message = "❌ Nenurodytas vartotojo ID."; }

if (!$message) {
    $id = (int)$_GET['id'];
    $stmt = $pdo->prepare("SELECT * FROM vartotojas WHERE ID=?");
    $stmt->execute([$id]);
    $user = $stmt->fetch();
    if (!$user) $message = "❌ Vartotojas nerastas.";
}

function other_admin_count(PDO $pdo, int $excludeId = 0): int {
    $st = $pdo->prepare("SELECT COUNT(*) FROM vartotojas WHERE Role='admin' AND ID<>?");
    $st->execute([$excludeId]);
    return (int)$st->fetchColumn();
}

if (!$message && $_SERVER['REQUEST_METHOD'] === 'POST') {
    if (!csrf_validate($_POST['csrf_token'] ?? '')) {
        $message = "❌ Neteisingas saugos žetonas.";
    } else {
        $vardas = trim($_POST['vardas'] ?? '');
        $el     = trim($_POST['el_pastas'] ?? '');
        $role   = $_POST['role'] ?? $user['Role'];
        $newp   = $_POST['naujas_slaptazodis'] ?? '';
        $newp2  = $_POST['naujas_slaptazodis2'] ?? '';

        // Guard: don't allow removing the last admin
        if ($user['Role'] === 'admin' && $role !== 'admin' && other_admin_count($pdo, $user['ID']) === 0) {
            $message = "❌ Negalima pašalinti paskutinio administratoriaus.";
        } elseif ($newp !== '' && ($newp !== $newp2 || strlen($newp) < 8)) {
            $message = "❌ Naujas slaptažodis netinkamas (≥8 ir sutapti).";
        } else {
            if ($newp !== '') {
                $hash = password_hash($newp, PASSWORD_DEFAULT);
                $stmt = $pdo->prepare("UPDATE vartotojas SET Vardas=?, El_pastas=?, Slaptazodis=?, Role=? WHERE ID=?");
                $ok = $stmt->execute([$vardas, $el, $hash, $role, $user['ID']]);
            } else {
                $stmt = $pdo->prepare("UPDATE vartotojas SET Vardas=?, El_pastas=?, Role=? WHERE ID=?");
                $ok = $stmt->execute([$vardas, $el, $role, $user['ID']]);
            }
            $message = $ok ? "✅ Vartotojas atnaujintas sėkmingai." : "❌ Klaida atnaujinant vartotoją.";
            if ($ok) { // reload
                $stmt = $pdo->prepare("SELECT * FROM vartotojas WHERE ID=?");
                $stmt->execute([$user['ID']]);
                $user = $stmt->fetch();
            }
        }
    }
}
?>
<!DOCTYPE html>
<html lang="lt">
<head>
    <meta charset="UTF-8">
    <title>Redaguoti vartotoją</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
<div class="container">
    <h2>Redaguoti vartotoją</h2>
    <?php if ($message): ?><p class="<?= str_starts_with($message,'❌')?'error':'' ?>"><?= $message ?></p><?php endif; ?>
    <?php if (!empty($user)): ?>
    <form method="post">
        <?= csrf_field() ?>
        <input name="vardas" value="<?= htmlspecialchars($user['Vardas']) ?>" required>
        <input name="el_pastas" type="email" value="<?= htmlspecialchars($user['El_pastas']) ?>" required>
        <input name="naujas_slaptazodis" type="password" placeholder="Naujas slaptažodis (neprivalomas)">
        <input name="naujas_slaptazodis2" type="password" placeholder="Pakartoti slaptažodį">
        <select name="role" required>
            <option value="naudotojas"   <?= $user['Role']==='naudotojas'?'selected':'' ?>>Naudotojas</option>
            <option value="inspektorius" <?= $user['Role']==='inspektorius'?'selected':'' ?>>Inspektorius</option>
            <option value="admin"        <?= $user['Role']==='admin'?'selected':'' ?>>Administratorius</option>
        </select>
        <button type="submit">Išsaugoti</button>
    </form>
    <?php endif; ?>
    <br><a href="manage_users.php">Grįžti</a>
</div>
</body>
</html>