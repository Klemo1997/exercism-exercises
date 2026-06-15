defmodule PigLatin do
  @alphabet Enum.to_list(?a .. ?z)
  @vowels [?a, ?e, ?i, ?o, ?u]
  @consonants @alphabet  -- @vowels
  defguardp is_vowel(v) when v in @vowels
  defguardp is_consonant(c) when c in @consonants

  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.
  """
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) when is_binary(phrase),
    do: phrase
      |> String.split()
      |> Enum.map_join(" ", &latinize/1)

  defp latinize(word),
    do: with(
      {prefix, rest} <- swappables(word),
      do: rest <> prefix <> "ay")

  defp swappables(word, consonants \\ <<>>)
  defp swappables(<<?x, c, _::binary>> = word, <<>>) when is_consonant(c), do: {<<>>, word}
  defp swappables(<<?y, c, _::binary>> = word, <<>>) when is_consonant(c), do: {<<>>, word}
  defp swappables(<<?y, _::binary>> = word, <<_, _::binary>> = consonants), do: {consonants, word}
  defp swappables(<<"qu", rest::binary>>, consonants), do: {consonants <> "qu", rest}
  defp swappables(<<v, _::binary>> = word, consonants) when is_vowel(v), do: {consonants, word}
  defp swappables(<<c, rest::binary>>, consonants) when is_consonant(c), do: swappables(rest, consonants <> <<c>>)
end
