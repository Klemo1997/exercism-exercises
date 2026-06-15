-module(strain).

-export([keep/2, discard/2]).

keep(Fn, List) -> keep(Fn, List, []).
keep(Fn, [Item | List], Result) -> 
    case Fn(Item) of
        false -> keep(Fn, List, Result);
        true -> keep(Fn, List, [Item | Result])
    end;
keep(Fn, [], Result) -> lists:reverse(Result).

discard(Fn, List) -> keep(fun(Item) -> not Fn(Item) end, List).
