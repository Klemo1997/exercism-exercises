-module(prime_factors).

-export([factors/1]).

factors(1) -> [];
factors(Value) -> factors(Value, []).

factors(Value, Factors) -> 
    Max = trunc(math:sqrt(Value)),
    Factor = first(fun (MaybeFactor) -> Value rem MaybeFactor == 0 end, lists:seq(2, Max)),
    case Factor of
        nil -> [Value | Factors];
        _ -> factors(Value div Factor, [Factor | Factors])
    end.

first(Predicate, [Item | Rest]) ->
    case Predicate(Item) of
        true -> Item;
        false -> first(Predicate, Rest)
    end;
first(Predicate, []) -> nil.