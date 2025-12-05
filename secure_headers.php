<?php
// secure_headers.php — send common security headers (idempotent)
if (!headers_sent()) {
    header("Content-Security-Policy: default-src 'self'; img-src 'self' https:; style-src 'self' 'unsafe-inline'; frame-ancestors 'none'");
    header('X-Content-Type-Options: nosniff');
    header('Referrer-Policy: no-referrer');
    header('X-Frame-Options: DENY'); // legacy for old browsers
    header('Permissions-Policy: geolocation=(), microphone=(), camera=()');
}
