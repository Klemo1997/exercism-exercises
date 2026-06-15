-module(minesweeper).

-export([annotate/1]).

annotate([]) -> [];
annotate([""]) -> [""];
annotate([FirstRow | _] = Board) ->
    TupleBoard = list_to_tuple(lists:map(fun (Row) -> list_to_tuple(Row) end, Board)),
    Rows = length(Board),
    Cols = length(FirstRow),
    BoardAccessor = fun 
        ({X, Y}) when X >= 0 andalso X < Rows andalso Y >= 0 andalso Y < Cols ->
            element(Y+1, element(X+1, TupleBoard));
        ({_, _}) -> nil
    end,
    Accessor = fun
        ({item, X, Y}) -> BoardAccessor({X, Y});
        ({mines_count, X, Y}) -> 
            Cells = [BoardAccessor({I, J}) || I <- lists:seq(X - 1, X + 1), J <- lists:seq(Y - 1, Y + 1)],
            length(lists:filter(fun(Cell) -> Cell == $* end, Cells))
    end,
    lists:map(
        fun (X) -> [annotate_cell(Accessor, X, Y) || Y <- lists:seq(0, Cols-1)] end,
        lists:seq(0, Rows-1)).

annotate_cell(Accessor, X, Y) ->
    case Accessor({item, X, Y}) of
        $\s ->
            Mines = Accessor({mines_count, X, Y}),
            if 
                Mines > 0 -> $0 + Mines;
                true -> $\s
            end; 
        Other -> Other
    end.
