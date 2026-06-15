<?php

declare(strict_types=1);

final class ProgramWindow
{
    public function __construct(
        public $x = 0,
        public $y = 0,
        public $width = 800,
        public $height = 600,
    ) {}

    public function resize(Size $size) {
        $this->width = $size->width;
        $this->height = $size->height;
    }

    public function move(Position $position) {
        $this->x = $position->x;
        $this->y = $position->y;
    }
}
