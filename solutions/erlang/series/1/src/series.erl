-module(series).

-export([slices/2]).

slices(Len, Series) when Len > length(Series) -> error(badarg);
slices(Len, Series) -> slices(Len, Series, []).

slices(Len, Series, Slices) when Len > length(Series) -> lists:reverse(Slices);
slices(Len, [_ | NextSeries] = Series, Slices) -> slices(Len, NextSeries, [slice(Len, Series) | Slices]).

slice(Len, Str) -> slice(Len, Str, []).
slice(0, Str, Slice) -> string:reverse(Slice);
slice(Len, [Char | Str], Slice) -> slice(Len - 1, Str, [Char | Slice]).
