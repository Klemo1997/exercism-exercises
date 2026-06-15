-module(darts).

-export([score/2]).


score(X, Y) -> 
    Zone = zone({X, Y}),
    points(Zone).

zone(Position) ->
    Radius = radius(Position),
    circle(Radius).

points(inner) -> 10;
points(middle) -> 5;
points(outer) -> 1;
points(outside) -> 0.

circle(Radius) when Radius =< 1 -> inner;
circle(Radius) when Radius =< 5 -> middle;
circle(Radius) when Radius =< 10 -> outer;
circle(_) -> outside.

radius({X, Y}) -> math:sqrt(X * X + Y * Y).
