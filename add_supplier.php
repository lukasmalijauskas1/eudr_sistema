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
        $pavadinimas = trim($_POST['pavadinimas'] ?? '');
        $adresas     = trim($_POST['adresas'] ?? '');
        $kontaktai   = trim($_POST['kontaktai'] ?? '');
        $slap        = $_POST['slaptazodis'] ?? '';
        $slap2       = $_POST['slaptazodis2'] ?? '';

        if ($slap !== $slap2 || strlen($slap) < 8) {
            $message = "❌ Slaptažodis turi būti ≥8 ir sutapti.";
        } else {
            $hash = password_hash($slap, PASSWORD_DEFAULT);

            try {
                $stmt = $pdo->prepare("INSERT INTO tiekejas (Pavadinimas, Adresas, Kontaktai, Slaptazodis) VALUES (?, ?, ?, ?)");
                $stmt->execute([$pavadinimas, $adresas, $kontaktai, $hash]);
                $message = "✅ Tiekėjas pridėtas sėkmingai.";
            } catch (PDOException $e) {
                $isDup = ($e->getCode() === '23000') ||
                         (isset($e->errorInfo[1]) && (int)$e->errorInfo[1] === 1062);
                if ($isDup) {
                    $message = "❌ Tiekėjas su tokiais kontaktais jau egzistuoja.";
                } else {
                    $message = "❌ Klaida pridedant tiekėją.";
                }
            }
        }
    }
}
?>
<!DOCTYPE html>
<html lang="lt">
<head><meta charset="UTF-8"><title>Pridėti tiekėją</title><link rel="stylesheet" href="style.css"></head>
<body>
<div class="container">
    <h2>Pridėti tiekėją</h2>
    <?php if ($message): ?><p class="<?= str_starts_with($message,'❌')?'error':'' ?>"><?= $message ?></p><?php endif; ?>
    <form method="post">
        <?= csrf_field() ?>
        <input name="pavadinimas" placeholder="Pavadinimas" required>
        <input name="adresas" placeholder="Adresas" required>
        <input name="kontaktai" placeholder="Kontaktai" required>
        <input name="slaptazodis" type="password" placeholder="Slaptažodis (≥8)" required>
        <input name="slaptazodis2" type="password" placeholder="Pakartoti slaptažodį" required>
        <button type="submit">Pridėti</button>
    </form>
    <br><a href="admindashboard.php">Grįžti</a>
</div>
</body>
</html>
