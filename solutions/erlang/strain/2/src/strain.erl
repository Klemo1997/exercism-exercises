-module(strain).

-export([keep/2, discard/2]).

keep(Fn, List) -> [Item || Item <- List, Fn(Item)].

discard(Fn, List) -> [Item || Item <- List, not Fn(Item)].
