<?php

declare(strict_types=1);

/** 
 * @returns string[]
 */
function language_list(...$languages): array
{
    return $languages;
}

/** 
 * @param string[] $list
 * @returns string[]
 */
function add_to_language_list(array $list, string $lang): array
{
    return [...$list, $lang];
}

/** 
 * @param string[] $list
 * @returns string[]
 */
function prune_language_list(array $list): array
{
    return array_slice($list, 1);
}

/** @param string[] $list */
function current_language(array $list): string
{
    return $list[0];
}

/** @param string[] $list */
function language_list_length(array $list): int
{
    return count($list);
}