<?php

declare(strict_types=1);

function encode(string $input): string
{
    if ($input === '') {
        return '';
    }
    
    $encoded = [];
    $length = strlen($input);
    [$last_letter, $repeated] = [$input[0], 1];
    
    for ($i = 1; $i <= $length; $i++) {
        if ($i < $length && $input[$i] === $last_letter) {
            $repeated++;
            continue;
        }

        $encoded[] = $repeated > 1
            ? "{$repeated}{$last_letter}"
            : $last_letter;

        [$last_letter, $repeated] = [$input[$i], 1];
    }

    return implode($encoded);
}

function decode(string $input): string
{
    $decoded = [];
    $length = strlen($input);

    $numeric_buffer = [];
    
    for ($i = 0; $i < $length; $i++) {
        if (is_numeric($input[$i])) {
            $numeric_buffer[] = $input[$i];
            continue;
        }
        
        $repeated = $numeric_buffer !== []
            ? (int) implode($numeric_buffer)
            : 1;
        $numeric_buffer = [];
        $decoded[] = str_repeat($input[$i], $repeated);
    }
    
    return implode($decoded);
}
