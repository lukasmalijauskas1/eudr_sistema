<?php
require_once 'secure_session.php';
require_once 'secure_headers.php';
require_once 'csrf.php';
require 'db.php';
require 'tfpdf/tfpdf.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST' || !csrf_validate($_POST['csrf_token'] ?? '')) {
    http_response_code(400); exit('Netinkama užklausa.');
}
if (!isset($_SESSION['user_id']) || ($_SESSION['role'] ?? '') !== 'naudotojas') {
    header("Location: login.php"); exit();
}

class PDF extends tFPDF {
    function Header() {
        $this->SetFont('DejaVu', '', 14);
        $this->Cell(0, 10, 'Produktų sąrašas', 0, 1, 'C');
        $this->Ln(5);
        $this->SetFont('DejaVu', '', 10);
        $this->Cell(45, 10, 'Pavadinimas', 1);
        $this->Cell(40, 10, 'Kilmės šalis', 1);
        $this->Cell(50, 10, 'Kategorija', 1);
        $this->Cell(55, 10, 'Tiekėjas', 1);
        $this->Ln();
    }
}

$pdf = new PDF();
$pdf->AddFont('DejaVu', '', 'DejaVuSans.ttf', true);
$pdf->SetFont('DejaVu', '', 10);
$pdf->AddPage();

$stmt = $pdo->query("
    SELECT p.Pavadinimas, p.Salis AS KilmesSalis, p.Kategorija, t.Pavadinimas AS TiekejasVardas
    FROM eudr_sistema.produktas p
    LEFT JOIN eudr_sistema.tiekejas t ON p.TiekejasID = t.ID
");

while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
    $pdf->Cell(45, 10, $row['Pavadinimas'], 1);
    $pdf->Cell(40, 10, $row['KilmesSalis'], 1);
    $pdf->Cell(50, 10, $row['Kategorija'], 1);
    $pdf->Cell(55, 10, $row['TiekejasVardas'] ?? 'Nenurodytas', 1);
    $pdf->Ln();
}

$pdf->Output('D', 'produktai.pdf'); exit;
