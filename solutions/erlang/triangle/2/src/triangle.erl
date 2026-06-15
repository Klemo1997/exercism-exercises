-module(triangle).

-export([kind/3]).

kind(A, B, C) when A + B < C orelse B + C < A orelse A + C < B ->
    {error, "side lengths violate triangle inequality"};
kind(A, B, C) when A =< 0 orelse B =< 0 orelse C =< 0 -> 
    {error, "all side lengths must be positive"};
kind(A, A, A) -> equilateral;
kind(A, A, _) -> isosceles;
kind(A, _, A) -> isosceles;
kind(_, A, A) -> isosceles;
kind(_, _, _) -> scalene.
