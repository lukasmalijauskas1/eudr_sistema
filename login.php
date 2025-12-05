<?php
require_once 'secure_session.php';
require_once 'secure_headers.php';
require_once 'db.php';
require_once 'csrf.php';

function is_hash_like(?string $s): bool {
    if (!$s) return false;
    return str_starts_with($s, '$2y$') || str_starts_with($s, '$argon2');
}

if ($_SERVER['REQUEST_METHOD'] === 'POST' && !csrf_validate($_POST['csrf_token'] ?? '')) {
    $_SESSION['login_error'] = "Neteisingas seanso žetonas. Bandykite dar kartą.";
    header("Location: login.php"); exit();
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $email    = trim($_POST['email'] ?? '');
    $password = (string)($_POST['password'] ?? '');

    // --- 1) Try vartotojas by email
    $stmt = $pdo->prepare("SELECT ID, Role, Vardas, Slaptazodis FROM vartotojas WHERE El_pastas = ? LIMIT 1");
    $stmt->execute([$email]);
    $u = $stmt->fetch(PDO::FETCH_ASSOC);

    $ok = false;
    if ($u) {
        $stored = $u['Slaptazodis'] ?? '';
        if (is_hash_like($stored)) {
            $ok = password_verify($password, $stored);
        } else {
            // legacy plain text
            $ok = hash_equals($stored, $password);
            if ($ok) {
                $newHash = password_hash($password, PASSWORD_DEFAULT);
                $upd = $pdo->prepare("UPDATE vartotojas SET Slaptazodis = ? WHERE ID = ?");
                $upd->execute([$newHash, $u['ID']]);
            }
        }
        if ($ok) {
            session_regenerate_id(true);
            $_SESSION['user_id']  = (int)$u['ID'];
            $_SESSION['role']     = $u['Role'];
            $_SESSION['username'] = $u['Vardas'];

            if ($u['Role'] === 'admin')          { header("Location: admindashboard.php"); exit(); }
            if ($u['Role'] === 'inspektorius')   { header("Location: inspectordashboard.php"); exit(); }
            if ($u['Role'] === 'naudotojas')     { header("Location: userdashboard.php"); exit(); }
            if ($u['Role'] === 'tiekejas')       { header("Location: supplierdashboard.php"); exit(); } // if you ever store suppliers in vartotojas
            $_SESSION['login_error'] = "Nežinomas vaidmuo.";
            header("Location: login.php"); exit();
        }
    }

    // --- 2) Try supplier by Kontaktai (you use the same email field for input)
    $stmt = $pdo->prepare("SELECT ID, Pavadinimas, Slaptazodis FROM tiekejas WHERE Kontaktai = ? LIMIT 1");
    $stmt->execute([$email]);
    $s = $stmt->fetch(PDO::FETCH_ASSOC);

    if ($s) {
        $stored = $s['Slaptazodis'] ?? '';
        if (is_hash_like($stored)) {
            $ok = password_verify($password, $stored);
        } else {
            $ok = hash_equals($stored, $password);
            if ($ok) {
                $newHash = password_hash($password, PASSWORD_DEFAULT);
                $upd = $pdo->prepare("UPDATE tiekejas SET Slaptazodis = ? WHERE ID = ?");
                $upd->execute([$newHash, $s['ID']]);
            }
        }
        if ($ok) {
            session_regenerate_id(true);
            $_SESSION['tiekejas_id']  = (int)$s['ID'];
            $_SESSION['role']         = 'tiekejas';
            $_SESSION['supplier_name']= $s['Pavadinimas'];
            header("Location: supplierdashboard.php"); exit();
        }
    }

    $_SESSION['login_error'] = "Neteisingi prisijungimo duomenys!";
    header("Location: login.php"); exit();
}
?>
<!DOCTYPE html>
<html lang="lt">
<head>
    <meta charset="UTF-8">
    <title>Prisijungimas</title>
    <link rel="stylesheet" href="style.css">
    <meta http-equiv="Cache-Control" content="no-store" />
</head>
<body class="forest-theme">
<div class="center-container">
    <div class="panel">
        <h2>Prisijungimas</h2>
        <form method="post" autocomplete="off">
            <?= csrf_field() ?>
            <input type="email" name="email" placeholder="El. paštas (ar tiekėjo kontaktai)" required><br>
            <input type="password" name="password" placeholder="Slaptažodis" required><br>
            <button type="submit">Prisijungti</button>
        </form>
        <?php if (!empty($_SESSION['login_error'])): ?>
            <p class="error"><?= htmlspecialchars($_SESSION['login_error']) ?></p>
            <?php unset($_SESSION['login_error']); ?>
        <?php endif; ?>
    </div>
</div>
</body>
</html>
