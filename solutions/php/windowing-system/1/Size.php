<?php

declare(strict_types=1);

final readonly class Size {
    public function __construct(
        public int $height,
        public int $width,
    ) {}
}