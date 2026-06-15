-module(accumulate).
-export([accumulate/2]).

%%
%% given a fun and a list, apply fun to each list item replacing list item with fun's return value.
%%
-spec accumulate(fun((A) -> B), list(A)) -> list(B).
accumulate(Fn, List) -> accumulate(Fn, List, []).

accumulate(Fn, [Head | List], Result) -> accumulate(Fn, List, [Fn(Head) | Result]);
accumulate(Fn, [], Result) -> lists:reverse(Result).