<?php
// twofa_lib.php — simple TOTP (RFC 6238-ish) + Base32 helpers (no external libs)

const TWOFA_DIGITS = 6;
const TWOFA_PERIOD = 30;  // seconds

function twofa_random_base32_secret(int $bytes = 20): string {
    $raw = random_bytes($bytes);
    return twofa_base32_encode($raw);
}

function twofa_verify_totp(string $base32Secret, string $userCode, int $window = 1): bool {
    $code = preg_replace('/\D+/', '', (string)$userCode);
    if ($code === '' || strlen($code) !== TWOFA_DIGITS) return false;

    $secret = twofa_base32_decode($base32Secret);
    if ($secret === '') return false;

    $t = time();
    $counter = (int) floor($t / TWOFA_PERIOD);

    for ($i = -$window; $i <= $window; $i++) {
        $expected = twofa_totp_at($secret, $counter + $i, TWOFA_DIGITS);
        if (hash_equals($expected, $code)) return true;
    }
    return false;
}

function twofa_totp_at(string $key, int $counter, int $digits = 6): string {
    // 8-byte big endian counter (safe for current epoch)
    $binCounter = pack('N2', 0, $counter);
    $hash = hash_hmac('sha1', $binCounter, $key, true);
    $offset = ord($hash[19]) & 0x0F;
    $part = substr($hash, $offset, 4);
    $num = unpack('N', $part)[1] & 0x7fffffff;
    $mod = 10 ** $digits;
    $otp = (string)($num % $mod);
    return str_pad($otp, $digits, '0', STR_PAD_LEFT);
}

/* ---------------- Base32 ---------------- */

function twofa_base32_encode(string $data): string {
    $alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ234567';
    $bits = '';
    $len = strlen($data);
    for ($i = 0; $i < $len; $i++) {
        $bits .= str_pad(decbin(ord($data[$i])), 8, '0', STR_PAD_LEFT);
    }
    $out = '';
    for ($i = 0; $i < strlen($bits); $i += 5) {
        $chunk = substr($bits, $i, 5);
        if (strlen($chunk) < 5) $chunk = str_pad($chunk, 5, '0', STR_PAD_RIGHT);
        $out .= $alphabet[bindec($chunk)];
    }
    return $out; // no '=' padding needed for our use
}

function twofa_base32_decode(string $b32): string {
    $alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ234567';
    $b32 = strtoupper($b32);
    $b32 = preg_replace('/[^A-Z2-7]/', '', $b32);

    $bits = '';
    $len = strlen($b32);
    for ($i = 0; $i < $len; $i++) {
        $pos = strpos($alphabet, $b32[$i]);
        if ($pos === false) return '';
        $bits .= str_pad(decbin($pos), 5, '0', STR_PAD_LEFT);
    }

    $out = '';
    for ($i = 0; $i + 8 <= strlen($bits); $i += 8) {
        $byte = substr($bits, $i, 8);
        $out .= chr(bindec($byte));
    }
    return $out;
}
