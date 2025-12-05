<?php
require_once 'secure_session.php';
require_once 'secure_headers.php';
require 'db.php';
require 'csrf.php';

if (($_SESSION['role'] ?? '') !== 'admin') { header("Location: login.php"); exit(); }

$message = "";
if (!isset($_GET['id'])) { $message = "❌ Nenurodytas tiekėjo ID."; }
if (!$message) {
    $id = (int)$_GET['id'];
    $stmt = $pdo->prepare("SELECT * FROM tiekejas WHERE ID=?");
    $stmt->execute([$id]);
    $supplier = $stmt->fetch();
    if (!$supplier) $message = "❌ Tiekėjas nerastas.";
}

if (!$message && $_SERVER['REQUEST_METHOD'] === 'POST') {
    if (!csrf_validate($_POST['csrf_token'] ?? '')) {
        $message = "❌ Neteisingas saugos žetonas.";
    } else {
        $pavadinimas = trim($_POST['pavadinimas'] ?? '');
        $adresas     = trim($_POST['adresas'] ?? '');
        $kontaktai   = trim($_POST['kontaktai'] ?? '');
        $slap        = $_POST['slaptazodis'] ?? '';
        $slap2       = $_POST['slaptazodis2'] ?? '';

        try {
            if ($slap !== '') {
                if ($slap !== $slap2 || strlen($slap) < 8) {
                    $message = "❌ Naujas slaptažodis netinkamas (≥8 ir sutapti).";
                } else {
                    $hash = password_hash($slap, PASSWORD_DEFAULT);
                    $stmt = $pdo->prepare("UPDATE tiekejas SET Pavadinimas=?, Adresas=?, Kontaktai=?, Slaptazodis=? WHERE ID=?");
                    $ok = $stmt->execute([$pavadinimas, $adresas, $kontaktai, $hash, $id]);
                    $message = $ok ? "✅ Tiekėjas atnaujintas sėkmingai." : "❌ Klaida atnaujinant tiekėją.";
                }
            } else {
                $stmt = $pdo->prepare("UPDATE tiekejas SET Pavadinimas=?, Adresas=?, Kontaktai=? WHERE ID=?");
                $ok = $stmt->execute([$pavadinimas, $adresas, $kontaktai, $id]);
                $message = $ok ? "✅ Tiekėjas atnaujintas sėkmingai." : "❌ Klaida atnaujinant tiekėją.";
            }
        } catch (PDOException $e) {
            $isDup = ($e->getCode() === '23000') ||
                     (isset($e->errorInfo[1]) && (int)$e->errorInfo[1] === 1062);
            if ($isDup) {
                $message = "❌ Tiekėjas su tokiais kontaktais jau egzistuoja.";
            } else {
                $message = "❌ Klaida atnaujinant tiekėją.";
            }
        }

        if (str_starts_with($message, '✅')) {
            $stmt = $pdo->prepare("SELECT * FROM tiekejas WHERE ID=?");
            $stmt->execute([$id]);
            $supplier = $stmt->fetch();
        }
    }
}
?>
<!DOCTYPE html>
<html lang="lt">
<head><meta charset="UTF-8"><title>Redaguoti tiekėją</title><link rel="stylesheet" href="style.css"></head>
<body>
<div class="container">
    <h2>Redaguoti tiekėją</h2>
    <?php if ($message): ?><p class="<?= str_starts_with($message,'❌')?'error':'' ?>"><?= $message ?></p><?php endif; ?>
    <?php if (!empty($supplier)): ?>
    <form method="post">
        <?= csrf_field() ?>
        <input name="pavadinimas" value="<?= htmlspecialchars($supplier['Pavadinimas']) ?>" required>
        <input name="adresas" value="<?= htmlspecialchars($supplier['Adresas']) ?>" required>
        <input name="kontaktai" value="<?= htmlspecialchars($supplier['Kontaktai']) ?>" required>
        <input name="slaptazodis" type="password" placeholder="Naujas slaptažodis (neprivalomas)">
        <input name="slaptazodis2" type="password" placeholder="Pakartoti slaptažodį">
        <button type="submit">Išsaugoti</button>
    </form>
    <?php endif; ?>
    <br><a href="manage_suppliers.php">Grįžti</a>
</div>
</body>
</html>
