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

    $solver = new Solver();
    $solver->solve(array_reverse($coins), $amount, [], $coins[array_key_last($coins)]);

    if ($solver->getResult() === null) {
        throw new InvalidArgumentException('No combination can add up to target');
    }

    return $solver->getResult();
}

class Solver {
    private ?array $result = null;

    /**
     * Keeping track of largest coin used, and using only coins up to its value drastically reduces
     * the tree of calls, since we're trying to find shortest path to zero amount, from largest coin, and back-tracking
     * to the optimal solution.
     * Once we have a solution, we never check anything that reaches the same size.
     * For better scalability we could introduce our own stack data structure instead of using call stack
     */
    public function solve(array $coins, int $remaining_amount, array $used_coins, int $max_coin): void
    {
        if ($remaining_amount === 0 && ($this->result === null || count($used_coins) < count($this->result))) {
            $this->result = $used_coins;
            return;
        }
        
        if ($this->result !== null && count($used_coins) >= count($this->result)) return;

        foreach ($coins as $coin) {
            if ($coin > $max_coin || $coin > $remaining_amount) continue;
            $this->solve($coins, $remaining_amount - $coin, [$coin, ...$used_coins], $coin);
        }
    }

    public function getResult(): ?array
    {
        return $this->result;
    }
}
