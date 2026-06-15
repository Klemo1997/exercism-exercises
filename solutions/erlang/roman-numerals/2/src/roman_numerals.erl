-module(roman_numerals).

-export([roman/1]).

% This is just for experimental purpose
% It is okay to omit the tailrec optimization, if we have control over
% number of recursive calls - in this case it won't go very deep, since
% we won't allow anything larger than 10_000 explicitly

roman(N) when N >= 10000 orelse N < 0 -> badarg;
roman(N) when N >= 1000 -> "M" ++ roman(N - 1000);
roman(N) when N >= 900  -> "CM" ++ roman(N - 900);
roman(N) when N >= 500  -> "D" ++ roman(N - 500);
roman(N) when N >= 400  -> "CD" ++ roman(N - 400);
roman(N) when N >= 100  -> "C" ++ roman(N - 100);
roman(N) when N >= 90   -> "XC" ++ roman(N - 90);
roman(N) when N >= 50   -> "L" ++ roman(N - 50);
roman(N) when N >= 40   -> "XL" ++ roman(N - 40);
roman(N) when N >= 10   -> "X" ++ roman(N - 10);
roman(9) -> "IX";
roman(N) when N >= 5 -> "V" ++ roman(N - 5);
roman(4) -> "IV";
roman(3) -> "III";
roman(2) -> "II";
roman(1) -> "I";
roman(0) -> "".
