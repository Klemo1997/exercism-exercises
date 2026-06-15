-module(anagram).

-export([find_anagrams/2]).


find_anagrams(Subject, Candidates) -> 
    LowcasedSubject = string:lowercase(Subject),
    SubjectFrequencies = list_frequencies(LowcasedSubject),
    lists:filter(
        fun(Candidate) -> 
            LowcasedCandidate = string:lowercase(Candidate),
            list_frequencies(LowcasedCandidate) == SubjectFrequencies andalso LowcasedCandidate /= LowcasedSubject 
        end, 
        Candidates
    ).

list_frequencies(List) -> lists:foldl(
                             fun(Item, Freq) -> maps:put(Item, maps:get(Item, Freq, 0) + 1, Freq) end, 
                             #{}, 
                             List
                          ).