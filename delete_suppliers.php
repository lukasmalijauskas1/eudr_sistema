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
if (!$id) { header("Location: manage_suppliers.php"); exit(); }

try {
    $pdo->beginTransaction();
    $stmt = $pdo->prepare("DELETE FROM tiekejas WHERE ID=?");
    $stmt->execute([$id]);
    $pdo->commit();

    $_SESSION['flash_success'] = "Tiekėjas sėkmingai pašalintas.";
    header("Location: manage_suppliers.php"); exit();

} catch (PDOException $e) {
    if ($pdo->inTransaction()) { $pdo->rollBack(); }

    $isFk = ($e->getCode() === '23000') || (isset($e->errorInfo[1]) && (int)$e->errorInfo[1] === 1451);

    $_SESSION['login_error'] = $isFk
        ? "❌ Negalima ištrinti šio tiekėjo, nes yra su juo susietų produktų ar kitų duomenų. "
          . "Pirma pašalinkite arba perkelkite susietus produktus kitam tiekėjui."
        : "❌ Įvyko klaida šalinant tiekėją.";

    header("Location: manage_suppliers.php"); exit();
}
