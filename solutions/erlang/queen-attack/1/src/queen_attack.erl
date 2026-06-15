-module(queen_attack).

-export([can_attack/2]).

can_attack({X_a, Y_a} = _WhiteQueen, {X_b, Y_b} = _BlackQueen) ->
    X_a == X_b 
    orelse Y_a == Y_b 
    orelse abs(X_a - X_b) == abs(Y_a - Y_b)
    .
