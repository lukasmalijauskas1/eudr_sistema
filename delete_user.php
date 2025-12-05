<?php
require_once 'secure_session.php';
require_once 'secure_headers.php';
require 'db.php';
require 'csrf.php';

if (($_SESSION['role'] ?? '') !== 'admin') { header("Location: login.php"); exit(); }
if ($_SERVER['REQUEST_METHOD'] !== 'POST' || !csrf_validate($_POST['csrf_token'] ?? '')) {
    http_response_code(400); exit('Netinkama užklausa.');
}

$id = (int)($_POST['id'] ?? 0);
if (!$id) { header("Location: manage_users.php"); exit(); }

// Negalima pašalinti savęs
if ($id === (int)($_SESSION['user_id'] ?? 0)) {
    $_SESSION['login_error'] = "Negalite pašalinti savo paskyros.";
    header("Location: manage_users.php"); exit();
}

// Nepašalink paskutinio administratoriaus
$st = $pdo->prepare("SELECT Role FROM vartotojas WHERE ID=?");
$st->execute([$id]);
$role = $st->fetchColumn();

if ($role === 'admin') {
    $cnt = (int)$pdo->query("SELECT COUNT(*) FROM vartotojas WHERE Role='admin'")->fetchColumn();
    if ($cnt <= 1) {
        $_SESSION['login_error'] = "Negalima ištrinti paskutinio administratoriaus.";
        header("Location: manage_users.php"); exit();
    }
}

try {
    $pdo->beginTransaction();
    $st = $pdo->prepare("DELETE FROM vartotojas WHERE ID=?");
    $st->execute([$id]);
    $pdo->commit();

    $_SESSION['flash_success'] = "Vartotojas sėkmingai pašalintas.";
    header("Location: manage_users.php"); exit();

} catch (PDOException $e) {
    if ($pdo->inTransaction()) { $pdo->rollBack(); }

    // 23000 + 1451 = FOREIGN KEY RESTRICT/NO ACTION
    $isFk = ($e->getCode() === '23000') || (isset($e->errorInfo[1]) && (int)$e->errorInfo[1] === 1451);

    $_SESSION['login_error'] = $isFk
        ? "❌ Negalima ištrinti šio vartotojo, nes su juo susieti įrašai (pvz., ataskaitos, atitikties patikros ar DDS). "
          . "Pirma pašalinkite / priskirkite kitam vartotojui susietus įrašus."
        : "❌ Įvyko klaida šalinant vartotoją.";

    header("Location: manage_users.php"); exit();
}
