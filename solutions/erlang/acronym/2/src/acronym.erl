-module(acronym).

-export([abbreviate/1]).

abbreviate(Phrase) -> 
    [H || [H | _] <- string:lexemes(string:uppercase(Phrase), " -_")].
