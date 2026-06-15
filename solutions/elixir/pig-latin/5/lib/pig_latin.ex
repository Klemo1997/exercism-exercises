defmodule PigLatin do
  @vowels [?a, ?e, ?i, ?o, ?u]
  defguardp is_vowel(v) when v in @vowels
  defguardp is_consonant(c) when c not in @vowels

  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.
  """
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase),
    do: phrase
      |> String.split()
      |> Enum.map_join(" ", &latinize/1)

    defp latinize(word),
      do: with(
        {consonants, rest} <- consonants_and_rest(word),
        do: rest <> consonants <> "ay")

  defp consonants_and_rest(word, consonants \\ <<>>)
  defp consonants_and_rest(<<v, _::binary>> = word, consonants) when is_vowel(v), do: {consonants, word}
  defp consonants_and_rest(<<?x, c, _::binary>> = word, <<>>) when is_consonant(c), do: {<<>>, word}
  defp consonants_and_rest(<<?y, c, _::binary>> = word, <<>>) when is_consonant(c), do: {<<>>, word}
  defp consonants_and_rest(<<?y, _::binary>> = word, <<_, _::binary>> = consonants), do: {consonants, word}
  defp consonants_and_rest(<<"qu", rest::binary>>, consonants), do: {consonants <> "qu", rest}
  defp consonants_and_rest(<<c, rest::binary>>, consonants), do: consonants_and_rest(rest, consonants <> <<c>>)
end