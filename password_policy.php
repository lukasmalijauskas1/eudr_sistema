<?php
// password_policy.php

const PASS_MIN_LEN = 12;

/**
 * Returns null if OK, otherwise returns an LT error message.
 */
function password_policy_error(string $pass): ?string {
    $len = function_exists('mb_strlen') ? mb_strlen($pass, 'UTF-8') : strlen($pass);

    if ($len < PASS_MIN_LEN) {
        return "❌ Slaptažodis per trumpas (≥12 simbolių).";
    }
    if (preg_match('/\s/u', $pass)) {
        return "❌ Slaptažodyje negali būti tarpų.";
    }
    if (!preg_match('/\p{Lu}/u', $pass)) {
        return "❌ Slaptažodyje turi būti bent viena didžioji raidė (pvz., A).";
    }
    if (!preg_match('/\p{Nd}/u', $pass)) {
        return "❌ Slaptažodyje turi būti bent vienas skaitmuo (0–9).";
    }
    // Special symbol = anything that's NOT a letter or a number
    if (!preg_match('/[^\p{L}\p{N}]/u', $pass)) {
        return "❌ Slaptažodyje turi būti bent vienas specialus simbolis (pvz., ! @ # $ %).";
    }
    return null;
}

/**
 * Prefer Argon2id when available, fallback to PASSWORD_DEFAULT.
 */
function password_hash_strong(string $pass): string {
    if (defined('PASSWORD_ARGON2ID')) {
        return password_hash($pass, PASSWORD_ARGON2ID);
    }
    return password_hash($pass, PASSWORD_DEFAULT);
}
