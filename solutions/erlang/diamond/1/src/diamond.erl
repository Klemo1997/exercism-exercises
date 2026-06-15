-module(diamond).

-export([rows/1]).

rows([$A]) -> ["A"];
rows([Letter]) when Letter > $A, Letter =< $Z -> 
    Letters = lists:reverse(lists:seq($A, Letter)),
    LettersWithPaddings = lists:reverse(with_index(Letters)),
    DiamondStructure = mirror(LettersWithPaddings),
    lists:map(fun row/1, DiamondStructure).

row({Letter, Padding}) ->
    Pad = string:copies(" ", Padding),
    Pad ++ diamond(Letter) ++ Pad.

diamond($A) -> "A";
diamond(Letter) -> 
    MiddleSpaces = (Letter - $B) * 2 + 1,
    [Letter] ++ string:copies(" ", MiddleSpaces) ++ [Letter].

with_index(List) -> with_index(List, 0, []).

with_index([Item | List], Index, Result) -> 
    with_index(List, Index + 1, [{Item, Index} | Result]);
with_index([], _, Result) -> lists:reverse(Result).

mirror([]) -> [];
mirror(List) -> 
    [_ | Reversed] = lists:reverse(List),
    List ++ Reversed.