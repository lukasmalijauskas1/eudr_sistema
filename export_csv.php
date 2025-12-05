<?php
require_once 'secure_session.php';
require_once 'secure_headers.php';
require_once 'csrf.php';
require 'db.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST' || !csrf_validate($_POST['csrf_token'] ?? '')) {
    http_response_code(400); exit('Netinkama užklausa.');
}
if (!isset($_SESSION['user_id']) || ($_SESSION['role'] ?? '') !== 'naudotojas') {
    header("Location: login.php"); exit();
}

header('Content-Type: text/csv; charset=utf-8');
header('Content-Disposition: attachment; filename=produktai.csv');

$output = fopen('php://output', 'w');
fwrite($output, "\xEF\xBB\xBF"); // BOM for Excel

fputcsv($output, ['Pavadinimas', 'Kilmės šalis', 'Kategorija', 'Tiekėjas']);

$stmt = $pdo->query("
    SELECT p.Pavadinimas, p.Salis AS KilmesSalis, p.Kategorija, t.Pavadinimas AS TiekejasVardas
    FROM eudr_sistema.produktas p
    LEFT JOIN eudr_sistema.tiekejas t ON p.TiekejasID = t.ID
");

while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
    fputcsv($output, [
        $row['Pavadinimas'],
        $row['KilmesSalis'],
        $row['Kategorija'],
        $row['TiekejasVardas'] ?? 'Nenurodytas'
    ]);
}
fclose($output); exit;
