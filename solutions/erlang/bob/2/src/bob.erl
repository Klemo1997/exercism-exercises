-module(bob).

-export([response/1]).

response(Sentence) -> 
    TrimmedSentence = string:trim(Sentence),
    IsYelling = is_yelling(TrimmedSentence),
    IsQuestion = is_question(TrimmedSentence),
    IsSilence = is_silence(TrimmedSentence),
    if 
      IsYelling and IsQuestion -> "Calm down, I know what I'm doing!";
      IsQuestion -> "Sure.";
      IsYelling -> "Whoa, chill out!";
      IsSilence -> "Fine. Be that way!";
      true -> "Whatever."
   end.

is_yelling(Sentence) -> (string:uppercase(Sentence) == Sentence) and (string:lowercase(Sentence) /= Sentence).

is_question("") -> false;
is_question(Sentence) -> hd(string:reverse(Sentence)) == $?.

is_silence("") -> true;
is_silence(_) -> false.