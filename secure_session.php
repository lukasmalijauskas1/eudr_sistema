<?php
// secure_session.php — hardened session bootstrap
$https = (!empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] !== 'off');

session_set_cookie_params([
    'lifetime' => 0,
    'path'     => '/',
    'domain'   => '',
    'secure'   => $https,
    'httponly' => true,
    'samesite' => 'Strict'
]);

if (session_status() !== PHP_SESSION_ACTIVE) {
    session_name('EUDRSESSID');
    session_start();
}

// rotate ID every 10 min or at first use
if (!isset($_SESSION['__rotated_at'])) {
    session_regenerate_id(true);
    $_SESSION['__rotated_at'] = time();
} elseif (time() - $_SESSION['__rotated_at'] > 600) {
    session_regenerate_id(true);
    $_SESSION['__rotated_at'] = time();
}
