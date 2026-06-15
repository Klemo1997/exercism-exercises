-module(prime_factors).

-export([factors/1]).

factors(Value) -> factors(Value, 2, []).
factors(1, _, Factors) -> Factors;
factors(Value, Factor, Factors) when Value rem Factor == 0 -> factors(Value div Factor, 2, [Factor | Factors]);
factors(Value, NonFactor, Factors) -> factors(Value, NonFactor + 1, Factors).