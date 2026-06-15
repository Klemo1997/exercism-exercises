-module(collatz_conjecture).

-export([steps/1]).

steps(N) when N > 0 -> steps(N, 0);
steps(_) -> error(badarg).

steps(1, Steps) -> Steps;
steps(N, Steps) when N rem 2 == 0 -> steps(N div 2, Steps + 1);
steps(N, Steps) -> steps(3*N + 1, Steps + 1).
