<?php
require_once 'secure_session.php';
require_once 'secure_headers.php';
require 'db.php';
require 'csrf.php';

if (($_SESSION['role'] ?? '') !== 'admin') { header("Location: login.php"); exit(); }

$message = "";

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if (!csrf_validate($_POST['csrf_token'] ?? '')) {
        $message = "❌ Neteisingas saugos žetonas.";
    } else {
        $vardas = trim($_POST['vardas'] ?? '');
        $el     = trim($_POST['el_pastas'] ?? '');
        $pass   = $_POST['slaptazodis'] ?? '';
        $pass2  = $_POST['slaptazodis2'] ?? '';
        $role   = $_POST['role'] ?? 'naudotojas';

        if ($pass !== $pass2) {
            $message = "❌ Slaptažodžiai nesutampa.";
        } elseif (strlen($pass) < 8) {
            $message = "❌ Slaptažodis per trumpas (≥8).";
        } else {
            $hash = password_hash($pass, PASSWORD_DEFAULT);
            try {
                $stmt = $pdo->prepare("INSERT INTO vartotojas (Vardas, El_pastas, Slaptazodis, Role) VALUES (?, ?, ?, ?)");
                $stmt->execute([$vardas, $el, $hash, $role]);
                $message = "✅ Vartotojas pridėtas sėkmingai.";
            } catch (PDOException $e) {
                $message = "❌ Klaida pridedant vartotoją (gal el. paštas jau naudojamas).";
            }
        }
    }
}
?>
<!DOCTYPE html>
<html lang="lt">
<head>
    <meta charset="UTF-8">
    <title>Pridėti vartotoją</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
<div class="container">
    <h2>Pridėti vartotoją</h2>
    <?php if ($message): ?><p class="<?= str_starts_with($message,'❌')?'error':'' ?>"><?= $message ?></p><?php endif; ?>
    <form method="post">
        <?= csrf_field() ?>
        <input name="vardas" placeholder="Vardas" required>
        <input name="el_pastas" type="email" placeholder="El. paštas" required>
        <input name="slaptazodis" type="password" placeholder="Slaptažodis (≥8)" required>
        <input name="slaptazodis2" type="password" placeholder="Pakartoti slaptažodį" required>
        <select name="role" required>
            <option value="naudotojas">Naudotojas</option>
            <option value="inspektorius">Inspektorius</option>
            <option value="admin">Administratorius</option>
        </select>
        <button type="submit">Pridėti</button>
    </form>
    <br><a href="admindashboard.php">Grįžti</a>
</div>
</body>
</html>
