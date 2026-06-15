-module(raindrops).

-export([convert/1]).

convert(Number) -> 
    Words = lists:concat([convert(Number, Divisor) || Divisor <- [3, 5, 7]]),
    case Words of
        "" -> integer_to_list(Number);
        _ -> Words
    end.

convert(N, 3) when N rem 3 == 0 -> "Pling";
convert(N, 5) when N rem 5 == 0 -> "Plang";
convert(N, 7) when N rem 7 == 0 -> "Plong";
convert(_, _) -> "".
