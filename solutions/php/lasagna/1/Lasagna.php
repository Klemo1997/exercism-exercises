<?php

declare(strict_types=1);

class Lasagna
{
    private const EXPECTED_COOK_TIME_MINUTES = 40;
    private const LAYER_COOKING_TIME_MUNUTES = 2;

    /**
     * Returns expected cook time of lasagnas in minutes
     */
    public function expectedCookTime(): int 
    {
        return self::EXPECTED_COOK_TIME_MINUTES;
    }

    /**
     * Returns remaining cook time of lasagnas in minutes
     */
    public function remainingCookTime(int $elapsed_minutes): int 
    {
        return $this->expectedCookTime() - $elapsed_minutes;
    }

    /**
     * Returns preparation time of lasagnas in minutes
     */
    public function totalPreparationTime(int $layers_to_prep): int
    {
        return self::LAYER_COOKING_TIME_MUNUTES * $layers_to_prep;
    }

    /**
     * Returns total elapsed time of preparing and cooking lasagna
     */
    public function totalElapsedTime(int $layers_to_prep, int $elapsed_minutes): int {
        return $this->totalPreparationTime($layers_to_prep) + $elapsed_minutes;
    }

    /**
     * Returns a message indicating that the lasagna is ready to eat
     */
    public function alarm(): string {
        return 'Ding!';
    }
}
