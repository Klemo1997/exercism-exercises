-module(bob).

-export([response/1]).

response(Sentence) -> 
    TrimmedSentence = string:trim(Sentence),
    IsYelling = isYelling(TrimmedSentence),
    IsQuestion = isQuestion(TrimmedSentence),
    IsSilence = isSilence(TrimmedSentence),
    if 
      IsYelling and IsQuestion -> "Calm down, I know what I'm doing!";
      IsQuestion -> "Sure.";
      IsYelling -> "Whoa, chill out!";
      IsSilence -> "Fine. Be that way!";
      true -> "Whatever."
   end.

isYelling(Sentence) -> (string:uppercase(Sentence) == Sentence) and (string:lowercase(Sentence) /= Sentence).

isQuestion("") -> false;
isQuestion(Sentence) -> hd(string:reverse(Sentence)) == $?.

isSilence("") -> true;
isSilence(_) -> false.