% SPDX-FileCopyrightText: 2025
%
% SPDX-License-Identifier: CC-BY-SA-4.0

-module(collatz_conjecture).

-export([steps/1]).

-spec steps(integer()) -> boolean().
steps(N) when N < 1 -> erlang:error(badarg);
steps(N) -> steps(N, 0).

steps(1, Steps) -> Steps;
steps(N, Steps) when N rem 2 == 0 -> steps(N div 2, Steps + 1);
steps(N, Steps) -> steps(3*N + 1, Steps + 1).