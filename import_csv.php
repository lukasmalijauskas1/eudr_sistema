<?php
require_once 'secure_session.php';
require_once 'secure_headers.php';
require_once 'csrf.php';
require 'db.php';

if (!isset($_SESSION['user_id']) || ($_SESSION['role'] ?? '') !== 'naudotojas') {
    header("Location: login.php"); exit();
}
if ($_SERVER['REQUEST_METHOD'] !== 'POST' || !csrf_validate($_POST['csrf_token'] ?? '') || empty($_FILES['csv_file'])) {
    $_SESSION['product_message'] = "❌ Netinkama užklausa.";
    header("Location: userdashboard.php"); exit();
}

$file = $_FILES['csv_file']['tmp_name'];
$utf8File = tempnam(sys_get_temp_dir(), 'utf8csv');
file_put_contents($utf8File, mb_convert_encoding(file_get_contents($file), 'UTF-8', 'auto'));

$h = fopen($utf8File, "r");
if ($h === false) {
    $_SESSION['product_message'] = "❌ Nepavyko atidaryti CSV failo.";
    header("Location: userdashboard.php"); exit();
}

$row = 0; $err = "";
while (($data = fgetcsv($h, 1000, ",")) !== false) {
    $row++;
    if ($row === 1) continue; // header

    $pavadinimas = trim($data[0] ?? '');
    $salis       = trim($data[1] ?? '');
    $kategorija  = trim($data[2] ?? '');
    $tiekejas    = trim($data[3] ?? '');

    if ($pavadinimas==='' || $salis==='' || $kategorija==='' || $tiekejas==='') { $err="❌ Nepilni duomenys (eil. $row)."; break; }

    $st = $pdo->prepare("SELECT 1 FROM saliu_sarasas WHERE salis=?"); $st->execute([$salis]); if(!$st->fetchColumn()){ $err="❌ Nežinoma šalis: $salis (eil. $row)."; break; }
    $st = $pdo->prepare("SELECT 1 FROM kategoriju_sarasas WHERE Kategorija=?"); $st->execute([$kategorija]); if(!$st->fetchColumn()){ $err="❌ Nežinoma kategorija: $kategorija (eil. $row)."; break; }

    $st = $pdo->prepare("SELECT ID FROM tiekejas WHERE Pavadinimas=?"); $st->execute([$tiekejas]); $tiekejasID = $st->fetchColumn();
    if (!$tiekejasID) { $err="❌ Tiekėjas '$tiekejas' nerastas (eil. $row)."; break; }

    $ins = $pdo->prepare("INSERT INTO produktas (Pavadinimas, Salis, Kategorija, TiekejasID) VALUES (?, ?, ?, ?)");
    $ins->execute([$pavadinimas, $salis, $kategorija, $tiekejasID]);
}
fclose($h); unlink($utf8File);

$_SESSION['product_message'] = $err ?: "✅ CSV produktai sėkmingai importuoti.";
header("Location: userdashboard.php"); exit();
