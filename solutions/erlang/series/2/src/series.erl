-module(series).

-export([slices/2]).

slices(Len, Series) when Len =< length(Series) -> slices(Len, Series, []).
slices(Len, Series, Slices) when Len > length(Series) -> lists:reverse(Slices);
slices(Len, [_ | NextSeries] = Series, Slices) -> slices(Len, NextSeries, [slice(Len, Series) | Slices]).

slice(Len, Str) -> string:substr(Str, 1, Len).
