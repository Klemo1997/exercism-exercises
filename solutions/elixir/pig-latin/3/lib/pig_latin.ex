defmodule PigLatin do
  @vowels [?a, ?e, ?i, ?o, ?u]

  def translate(phrase),
    do: phrase
      |> String.split()
      |> Enum.map(&translate_word/1)
      |> Enum.join(" ")

  defp translate_word(<<char::utf8, _::bitstring>> = word) when char in @vowels,
    do: word <> "ay"
  defp translate_word(<<first::utf8, second::utf8, _::bitstring>> = word)
    when first in [?x, ?y] and second not in @vowels,
    do: word <> "ay"
  defp translate_word(word), do: transform_consonant(word)

  defp transform_consonant(word, consonants \\ <<>>)
  defp transform_consonant(<<>>, consonants),
    do: consonants <> "ay"
  defp transform_consonant(<<?y::utf8, _::bitstring>> = word, consonants) 
    when consonants != "",
    do: word <> consonants <> "ay"
  defp transform_consonant(<<char::utf8, _::bitstring>> = word, consonants) 
    when char in @vowels,
    do: word <> consonants <> "ay"
  defp transform_consonant(<<"qu", rest::bitstring>>, consonants),
    do: transform_consonant(rest, <<consonants::bitstring, "qu">>)
  defp transform_consonant(<<consonant::utf8, rest::bitstring>>, consonants),
    do: transform_consonant(rest, <<consonants::bitstring, consonant::utf8>>)
end
