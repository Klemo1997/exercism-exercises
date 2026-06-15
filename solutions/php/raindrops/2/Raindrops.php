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

const NUMBER_TO_WORD = [3 => 'Pling', 5 => 'Plang', 7 => 'Plong'];

function raindrops(int $number): string
{
    return pipe(
        array_keys(NUMBER_TO_WORD),
        static fn ($numbers) => array_filter($numbers, static fn ($divisor) => $number % $divisor === 0),
        static fn ($numbers) => array_map(static fn ($divisor) => NUMBER_TO_WORD[$divisor], $numbers),
        static fn ($words) => implode('', $words),
        static fn ($result) => $result !== '' ? $result : (string) $number,
    );
}

function pipe($arg, ...$functions) {
    return array_reduce($functions, static fn ($acc, $func) => $func($acc), $arg);
} 