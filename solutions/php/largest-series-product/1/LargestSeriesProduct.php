<?php

declare(strict_types=1);

function assert_that(bool $invariant,  Throwable $exception) {
    if (!$invariant) {
        throw $exception;
    }
}

final class Series
{
    /**
     * @param positive-int $input
     */
    private readonly int $size;
    
    /**
     * @param numeric-string $input
     */
    public function __construct(private readonly string $input)
    {
        assert_that(is_numeric($input), new InvalidArgumentException());
        $this->size = strlen($input);
        assert_that($this->size > 0, new InvalidArgumentException());
    }

    /**
     * @param positive-int $span
     */
    public function largestProduct(int $span): int
    {
        assert_that($span > 0, new InvalidArgumentException());
        assert_that($span <= $this->size, new InvalidArgumentException());

        $max_product = 0;

        for ($i = 0; $i < $this->size - ($span - 1); $i++) {
            $max_product = max($max_product, $this->productOf($i, $span));
        }

        return $max_product;
    }

    private function productOf(int $start, int $span): int
    {
        return array_reduce(
            range($start, $start + ($span - 1)),
            fn (int $running_product, int $i) => $running_product * (int) $this->input[$i],
            1,
        );
    }
}
