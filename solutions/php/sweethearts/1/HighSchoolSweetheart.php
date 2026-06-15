<?php

declare(strict_types=1);

final class HighSchoolSweetheart
{
    public function firstLetter(string $name): string
    {
        $trimmed_name = trim($name);
        assert(mb_strlen($trimmed_name) > 0);
        return $trimmed_name[0];
    }

    public function initial(string $name): string
    {
        return ucfirst($this->firstLetter($name)) . '.';
    }

    public function initials(string $name): string
    {
        [$first_name, $last_name] = explode(' ', $name);
        assert($first_name !== null);
        assert($last_name !== null);
        return $this->initial($first_name) . ' ' . $this->initial($last_name);
    }

    public function pair(string $sweetheart_a, string $sweetheart_b): string
    {
        $a = $this->initials($sweetheart_a);
        $b = $this->initials($sweetheart_b);
        return <<<EXPECTED_HEART
             ******       ******
           **      **   **      **
         **         ** **         **
        **            *            **
        **                         **
        **     {$a}  +  {$b}     **
         **                       **
           **                   **
             **               **
               **           **
                 **       **
                   **   **
                     ***
                      *
        EXPECTED_HEART;
    }
}
