<?php
require_once 'secure_session.php';
require_once 'secure_headers.php';
require 'db.php';
require 'csrf.php';

if (($_SESSION['role'] ?? '') !== 'tiekejas') { header("Location: login.php"); exit(); }
if ($_SERVER['REQUEST_METHOD'] !== 'POST' || !csrf_validate($_POST['csrf_token'] ?? '')) {
    $_SESSION['product_message'] = "❌ Netinkama užklausa.";
    header("Location: supplierdashboard.php"); exit();
}

$id = (int)($_POST['id'] ?? 0);
$tiekejas_id = (int)($_SESSION['tiekejas_id'] ?? 0);
if (!$id || !$tiekejas_id) {
    $_SESSION['product_message'] = "❌ Nenurodytas produkto ID.";
    header("Location: supplierdashboard.php"); exit();
}

/* check ownership */
$chk = $pdo->prepare("SELECT ID FROM produktas WHERE ID=? AND TiekejasID=?");
$chk->execute([$id, $tiekejas_id]);
if (!$chk->fetch()) {
    $_SESSION['product_message'] = "❌ Produktas nerastas arba neturite teisės.";
    header("Location: supplierdashboard.php"); exit();
}

try {
    $pdo->beginTransaction();

    // remove dependent rows first (FK → produktas)
    $del = $pdo->prepare("DELETE FROM atitiktiespatikra WHERE ProduktasID=?");
    $del->execute([$id]);

    $del = $pdo->prepare("DELETE FROM ataskaita WHERE ProduktasID=?");
    $del->execute([$id]);

    if ($pdo->query("SHOW TABLES LIKE 'dd_statement'")->rowCount() > 0) {
        $del = $pdo->prepare("DELETE FROM dd_statement WHERE ProduktasID=?");
        $del->execute([$id]);
    }

    // delete the product
    $del = $pdo->prepare("DELETE FROM produktas WHERE ID=? AND TiekejasID=?");
    $del->execute([$id, $tiekejas_id]);

    $pdo->commit();
    $_SESSION['product_message'] = "✅ Produktas sėkmingai ištrintas.";
} catch (PDOException $e) {
    if ($pdo->inTransaction()) $pdo->rollBack();
    $_SESSION['product_message'] = "❌ Klaida trinant produktą.";
}
header("Location: supplierdashboard.php"); exit();
