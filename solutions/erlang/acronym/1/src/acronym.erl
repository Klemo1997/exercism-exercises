-module(acronym).

-export([abbreviate/1]).

abbreviate(Phrase) -> 
    Words = re:split(Phrase, "[\\s-_]+", [{return,list}]),
    lists:map(fun(Word) -> acronym_part(Word) end, Words).

acronym_part(Word) ->
    hd(string:next_grapheme(
        unicode:characters_to_binary(string:uppercase(Word))
    )).
