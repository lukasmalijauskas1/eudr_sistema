<?php
require_once 'secure_session.php';
require_once 'secure_headers.php';
require_once 'db.php';
require_once 'csrf.php';
require_once 'twofa_lib.php';

if (empty($_SESSION['twofa_pending']) || empty($_SESSION['twofa_pending']['type']) || empty($_SESSION['twofa_pending']['id'])) {
    header("Location: login.php"); exit();
}

$type = $_SESSION['twofa_pending']['type'];  // 'vartotojas' or 'tiekejas'
$id   = (int)$_SESSION['twofa_pending']['id'];

function load_account(PDO $pdo, string $type, int $id): array {
    if ($type === 'vartotojas') {
        $st = $pdo->prepare("SELECT ID, Vardas, El_pastas, Role, twofa_enabled, twofa_secret, twofa_confirmed FROM vartotojas WHERE ID=? LIMIT 1");
    } else {
        $st = $pdo->prepare("SELECT ID, Pavadinimas, Kontaktai, twofa_enabled, twofa_secret, twofa_confirmed FROM tiekejas WHERE ID=? LIMIT 1");
    }
    $st->execute([$id]);
    $row = $st->fetch(PDO::FETCH_ASSOC);
    return $row ?: [];
}

function finalize_login(string $type, array $row): void {
    session_regenerate_id(true);

    if ($type === 'vartotojas') {
        $_SESSION['user_id']  = (int)$row['ID'];
        $_SESSION['role']     = (string)$row['Role'];
        $_SESSION['username'] = (string)$row['Vardas'];
    } else {
        $_SESSION['tiekejas_id']   = (int)$row['ID'];
        $_SESSION['role']          = 'tiekejas';
        $_SESSION['supplier_name'] = (string)$row['Pavadinimas'];
    }

    unset($_SESSION['twofa_pending']);
}

$row = load_account($pdo, $type, $id);
if (!$row || (int)($row['twofa_enabled'] ?? 0) !== 1) {
    header("Location: login.php"); exit();
}

if ((int)($row['twofa_confirmed'] ?? 0) === 1) {
    header("Location: twofa_verify.php"); exit();
}

// ensure secret exists
$secret = (string)($row['twofa_secret'] ?? '');
if ($secret === '') {
    $secret = twofa_random_base32_secret(20); // 20 bytes -> nice secret length
    if ($type === 'vartotojas') {
        $u = $pdo->prepare("UPDATE vartotojas SET twofa_secret=? WHERE ID=?");
    } else {
        $u = $pdo->prepare("UPDATE tiekejas SET twofa_secret=? WHERE ID=?");
    }
    $u->execute([$secret, $id]);
}

$issuer = 'EUDR_SISTEMA';
$labelValue = ($type === 'vartotojas') ? ($row['El_pastas'] ?? '') : ($row['Kontaktai'] ?? '');
$label = $issuer . ':' . $labelValue;
$otpauth = "otpauth://totp/" . rawurlencode($label)
    . "?secret=" . rawurlencode($secret)
    . "&issuer=" . rawurlencode($issuer)
    . "&digits=" . TWOFA_DIGITS
    . "&period=" . TWOFA_PERIOD;

// QuickChart QR (simple external image, works with your CSP img-src https:)
$qrUrl = "https://quickchart.io/qr?text=" . rawurlencode($otpauth) . "&size=220";

$error = '';
$tooMany = false;

// simple session rate limit
$_SESSION['twofa_attempts'] ??= 0;
$_SESSION['twofa_lock_until'] ??= 0;
if (time() < (int)$_SESSION['twofa_lock_until']) $tooMany = true;

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if (!csrf_validate($_POST['csrf_token'] ?? '')) {
        $error = "❌ Netinkama užklausa.";
    } elseif ($tooMany) {
        $error = "❌ Per daug bandymų. Palaukite ir bandykite dar kartą.";
    } else {
        $code = (string)($_POST['code'] ?? '');
        if (!twofa_verify_totp($secret, $code, 1)) {
            $_SESSION['twofa_attempts']++;
            if ($_SESSION['twofa_attempts'] >= 5) {
                $_SESSION['twofa_lock_until'] = time() + 30; // 30s lock
            }
            $error = "❌ Neteisingas kodas.";
        } else {
            // confirm setup
            if ($type === 'vartotojas') {
                $u = $pdo->prepare("UPDATE vartotojas SET twofa_confirmed=1 WHERE ID=?");
            } else {
                $u = $pdo->prepare("UPDATE tiekejas SET twofa_confirmed=1 WHERE ID=?");
            }
            $u->execute([$id]);

            // reset rate limit + log user in immediately
            $_SESSION['twofa_attempts'] = 0;
            $_SESSION['twofa_lock_until'] = 0;

            $row = load_account($pdo, $type, $id);
            finalize_login($type, $row);

            // redirect by role
            if ($type === 'vartotojas') {
                if ($row['Role'] === 'admin')        { header("Location: admindashboard.php"); exit(); }
                if ($row['Role'] === 'inspektorius') { header("Location: inspectordashboard.php"); exit(); }
                header("Location: userdashboard.php"); exit();
            } else {
                header("Location: supplierdashboard.php"); exit();
            }
        }
    }
}
?>
<!DOCTYPE html>
<html lang="lt">
<head>
  <meta charset="UTF-8">
  <title>2FA nustatymas</title>
  <link rel="stylesheet" href="style.css">
  <meta http-equiv="Cache-Control" content="no-store" />
</head>
<body class="forest-theme">
<div class="center-container">
  <div class="panel" style="max-width:520px;">
    <h2>2FA nustatymas</h2>

    <div class="card">
      <p style="color:#111;">
        Nuskenuokite QR kodą autentifikatoriaus programėle (Google/Microsoft Authenticator), arba įveskite slaptą raktą ranka.
      </p>

      <div style="text-align:center; margin:12px 0;">
        <img src="<?= htmlspecialchars($qrUrl) ?>" alt="2FA QR" style="border-radius:10px; background:#fff; padding:10px;">
      </div>

      <p style="color:#111;"><strong>Slaptas raktas (Base32):</strong><br>
        <code><?= htmlspecialchars($secret) ?></code>
      </p>

      <form method="post" autocomplete="off" style="margin-top:12px;">
        <?= csrf_field() ?>
        <input name="code" inputmode="numeric" pattern="[0-9]{6}" maxlength="6" placeholder="6 skaitmenų kodas" required>
        <button type="submit">Patvirtinti 2FA</button>
      </form>

      <?php if ($error): ?>
        <p class="error"><?= htmlspecialchars($error) ?></p>
      <?php endif; ?>
    </div>

    <a href="logout.php" style="color:#f1c40f;">Atsijungti</a>
  </div>
</div>
</body>
</html>
