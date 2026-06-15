-module(anagram).

-export([find_anagrams/2]).


find_anagrams(Subject, Candidates) -> 
    IsAnagram = is_anagram_for(Subject),
    lists:filter(IsAnagram, Candidates).

is_anagram_for(Subject) ->
    LowcasedSubject = string:lowercase(Subject),
    SubjectFrequencies = list_frequencies(LowcasedSubject),
    fun (Candidate) -> 
        LowcasedCandidate = string:lowercase(Candidate),
        CandidateFrequencies = list_frequencies(LowcasedCandidate),
        SubjectFrequencies == CandidateFrequencies andalso LowcasedCandidate /= LowcasedSubject
    end.

list_frequencies(List) -> lists:foldl(fun(Item, Freq) -> maps:put(Item, maps:get(Item, Freq, 0) + 1, Freq) end, #{}, List).