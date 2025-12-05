<?php 
require_once 'secure_session.php';
require_once 'secure_headers.php';
if (!isset($_SESSION['role']) || $_SESSION['role'] !== 'admin') {
    header('Location: login.php');
    exit();
}
?>

<!DOCTYPE html>
<html lang="lt">
<head>
    <meta charset="UTF-8">
    <title>Administratoriaus skydelis</title>
    <link rel="stylesheet" href="style.css">
</head>
<body class="forest-theme">
    <div class="center-container">
        <div class="panel">
            <h2>Sveiki, Administratoriau!</h2>

            <div class="card">
                <h3>Vartotojų valdymas</h3>
                <a href="add_user.php">Pridėti vartotoją</a> |
                <a href="manage_users.php">Tvarkyti vartotojus</a>
            </div>

            <div class="card">
                <h3>Tiekėjų valdymas</h3>
                <a href="add_supplier.php">Pridėti tiekėją</a> |
                <a href="manage_suppliers.php">Tvarkyti tiekėjus</a>
            </div>

            <br>
            <a href="logout.php" style="color: #f1c40f;">Atsijungti</a>
        </div>
    </div>
</body>
</html>
