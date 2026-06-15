defmodule PigLatin do
  @vowels [?a, ?e, ?i, ?o, ?u]
  defguardp is_vowel(v) when v in @vowels
  defguardp is_consonant(c) when c not in @vowels
  defguardp is_empty(prefix) when prefix === <<>>

  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.
  """
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase),
    do: phrase
      |> String.split()
      |> Enum.map_join(" ", &latinize/1)

  defp latinize(word, consonant_prefix \\ <<>>)
  defp latinize(<<c, _::bitstring>> = word, consonant_prefix) when is_vowel(c), do: word <> consonant_prefix <> "ay"
  defp latinize(<<?x, c, _::bitstring>> = word, <<>>) when is_consonant(c), do: word <> "ay"
  defp latinize(<<?y, c, _::bitstring>> = word, <<>>) when is_consonant(c), do: word <> "ay"
  defp latinize(<<?y, _::bitstring>> = word, consonant_prefix) when not is_empty(consonant_prefix), do: word <> consonant_prefix <> "ay"
  defp latinize(<<"qu", rest::bitstring>>, consonant_prefix), do: rest <> consonant_prefix <> "quay"
  defp latinize(<<c, rest::bitstring>>, consonant_prefix), do: latinize(rest, consonant_prefix <> <<c>>)
end
