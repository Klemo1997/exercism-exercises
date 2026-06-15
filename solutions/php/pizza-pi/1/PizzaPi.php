<?php

declare(strict_types=1);

final class PizzaPi
{    
    private const DOUGH_PIZZA_BASE_GRAMS = 200;
    private const DOUGH_PIZZA_PERSON_GRAMS = 20;
    
    /**
     * @param non-negative-int $pizzas
     * @param non-negative-int $people
     * @returns non-negative-int
     */
    public function calculateDoughRequirement(int $pizzas, int $people): int
    {
        assert($pizzas >= 0);
        assert($people >= 0);
        return $pizzas * (($people * self::DOUGH_PIZZA_PERSON_GRAMS) + self::DOUGH_PIZZA_BASE_GRAMS);
    }

    private const SAUCE_PER_PIZZA_MILLIS = 125;

    /**
     * @param non-negative-int $pizzas
     * @param non-negative-int $people
     * @returns non-negative-int
     */
    public function calculateSauceRequirement(int $pizzas, int $sauce_can_volume): int
    {
        assert($pizzas >= 0);
        assert($sauce_can_volume >= 0);
        return (int) ceil($pizzas * self::SAUCE_PER_PIZZA_MILLIS / $sauce_can_volume);
    }

    /**
     * @param non-negative-int $cheese_dimension
     * @param float $thickness
     * @param positive-int $diameter
     * @returns non-negative-int
     */
    public function calculateCheeseCubeCoverage(int $cheese_dimension, float $thickness, int $diameter): int
    {
        assert($cheese_dimension >= 0);
        assert($thickness > 0);
        assert($diameter > 0);
        return (int) floor(($cheese_dimension ** 3) / ($thickness * pi() * $diameter));
    }

    private const PIZZA_SLICES = 8;

    /**
     * @param non-negative-int $pizzas
     * @param non-negative-int $people
     * @returns non-negative-int
     */
    public function calculateLeftOverSlices(int $pizzas, int $people): int
    {
        return ($pizzas * self::PIZZA_SLICES) % $people;
    }
}
