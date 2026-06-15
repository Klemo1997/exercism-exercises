<?php

/*
 * By adding type hints and enabling strict type checking, code can become
 * easier to read, self-documenting and reduce the number of potential bugs.
 * By default, type declarations are non-strict, which means they will attempt
 * to change the original type to match the type specified by the
 * type-declaration.
 *
 * In other words, if you pass a string to a function requiring a float,
 * it will attempt to convert the string value to a float.
 *
 * To enable strict mode, a single declare directive must be placed at the top
 * of the file.
 * This means that the strictness of typing is configured on a per-file basis.
 * This directive not only affects the type declarations of parameters, but also
 * a function's return type.
 *
 * For more info review the Concept on strict type checking in the PHP track
 * <link>.
 *
 * To disable strict typing, comment out the directive below.
 */

declare(strict_types=1);

/**
 * For this algorithm to work, we expect $coins to contain ascendingly sorted array
 * @param int[] $coins
 * @returns int[]
 */
function findFewestCoins(array $coins, int $amount): array
{
    if ($amount < 0) throw new InvalidArgumentException('Cannot make change for negative value');
    if ($amount === 0) return [];
    if ($amount < $coins[0]) throw new InvalidArgumentException('No coins small enough to make change');
    $cache = [0 => []];
    foreach ($coins as $coin) {
        $cache[$coin] = [$coin];
    }

    foreach (range(0, $amount) as $amt) {
        foreach ($coins as $coin) {
            if ($coin > $amt) {
                continue;
            }

            if (!array_key_exists($amt - $coin, $cache)) {
                continue;
            }

            $candidate = [$coin, ...$cache[$amt - $coin]];

            if (!array_key_exists($amt, $cache) || count($candidate) < count($cache[$amt])) {
                $cache[$amt] = $candidate;
            }
        }
    }

    if (!array_key_exists($amount, $cache)) {
        throw new InvalidArgumentException('No combination can add up to target');
    }

    return $cache[$amount];
}