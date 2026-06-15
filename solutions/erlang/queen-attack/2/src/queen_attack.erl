-module(queen_attack).

-export([can_attack/2]).

can_attack({X, _}, {X, _}) -> true;
can_attack({_, Y}, {_, Y}) -> true;
can_attack({X_a, Y_a}, {X_b, Y_b}) -> abs(X_a - X_b) == abs(Y_a - Y_b).