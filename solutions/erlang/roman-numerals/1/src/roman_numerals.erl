-module(roman_numerals).

-export([roman/1]).


roman(N) -> roman(N, []).

roman(N, Roman) when N >= 1000 -> roman(N - 1000, [$M | Roman]);
roman(N, Roman) when N >= 900  -> roman(N - 900, [$M, $C | Roman]);
roman(N, Roman) when N >= 500  -> roman(N - 500, [$D | Roman]);
roman(N, Roman) when N >= 400  -> roman(N - 400, [$D, $C | Roman]);
roman(N, Roman) when N >= 100  -> roman(N - 100, [$C | Roman]);
roman(N, Roman) when N >= 90   -> roman(N - 90, [$C, $X | Roman]);
roman(N, Roman) when N >= 50   -> roman(N - 50, [$L | Roman]);
roman(N, Roman) when N >= 40   -> roman(N - 40, [$L, $X | Roman]);
roman(N, Roman) when N >= 10   -> roman(N - 10, [$X | Roman]);
roman(9, Roman) -> roman(0, [$X, $I | Roman]);
roman(N, Roman) when N >= 5    -> roman(N - 5, [$V | Roman]);
roman(4, Roman) -> roman(0, [$V, $I | Roman]);
roman(3, Roman) -> roman(0, [$I, $I, $I | Roman]);
roman(2, Roman) -> roman(0, [$I, $I | Roman]);
roman(1, Roman) -> roman(0, [$I | Roman]);
roman(0, Roman) -> string:reverse(Roman).
