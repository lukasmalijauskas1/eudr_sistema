<?php
// SECURE download_report.php (keeps ?file=... links)
require_once 'secure_session.php';
require_once 'secure_headers.php';
require_once 'db.php';

function deny($code = 403, $msg = 'Prieiga negalima.') {
    http_response_code($code);
    exit($msg);
}

if (!isset($_SESSION['role'])) deny(401, 'Reikia prisijungti.');
$role   = $_SESSION['role'];
$userId = (int)($_SESSION['user_id'] ?? 0);

// 1) Input
$given = $_GET['file'] ?? '';
if ($given === '') deny(400, 'Trūksta failo parametro.');
$base  = basename($given); // neutralize paths like ../../x.pdf

// 2) Find the owning record in DB (reports OR DDS) by exact stored path
//    Your DB stores "ataskaitos/<name>.pdf" — build that canonical relative path.
$rel = 'ataskaitos/' . $base;

// Try ataskaita first (user reports)
$owner = null;   // ['table' => 'ataskaita'|'dds', 'uid' => int, 'path' => string]
$st = $pdo->prepare("SELECT VartotojasID, PDFNuoroda FROM ataskaita WHERE PDFNuoroda = ? LIMIT 1");
$st->execute([$rel]);
if ($row = $st->fetch(PDO::FETCH_ASSOC)) {
    $owner = ['table'=>'ataskaita', 'uid'=>(int)$row['VartotojasID'], 'path'=>$row['PDFNuoroda']];
} else {
    // Try dd_statement
    $st = $pdo->prepare("SELECT VartotojasID, PDFNuoroda FROM dd_statement WHERE PDFNuoroda = ? LIMIT 1");
    $st->execute([$rel]);
    if ($row = $st->fetch(PDO::FETCH_ASSOC)) {
        $owner = ['table'=>'dds', 'uid'=>(int)$row['VartotojasID'], 'path'=>$row['PDFNuoroda']];
    }
}

if (!$owner) deny(404, 'Failas nerastas.');

// 3) Authorization
$allowed = false;
switch ($role) {
    case 'admin':
    case 'inspektorius':
        $allowed = true;  // may download any
        break;
    case 'naudotojas':
        // only own items
        $allowed = ($owner['uid'] === $userId);
        break;
    case 'tiekejas':
        // suppliers should NOT access user reports/DDS
        $allowed = false;
        break;
    default:
        $allowed = false;
}
if (!$allowed) deny(403, 'Neturite teisės atsisiųsti šio failo.');

// 4) Build a safe absolute path and ensure it lives under /ataskaitos
$baseDir = realpath(__DIR__ . '/ataskaitos');
$full    = realpath(__DIR__ . '/' . ltrim($owner['path'], '/'));
if ($full === false || $baseDir === false || strncmp($full, $baseDir, strlen($baseDir)) !== 0 || !is_file($full)) {
    deny(404, 'Failas nerastas diske.');
}

// 5) Serve the file
header('Content-Type: application/pdf');
header('Content-Disposition: attachment; filename="' . basename($full) . '"');
header('Content-Length: ' . filesize($full));
header('X-Content-Type-Options: nosniff');
header('Cache-Control: private, no-store');
readfile($full);
exit;
