defmodule PigLatin do
  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.
  """
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase), 
    do: phrase
      |> String.split() 
      |> Enum.map(&transform(&1))
      |> Enum.join(" ")

  @vowels [?a,?e,?i,?o,?u]
  
  defp transform(word, consonants \\ <<>>)
  defp transform(<<>>, consonants), do: consonants

  # Consonant starting words
  Enum.each(@vowels, fn vowel -> 
    defp transform(<<unquote(vowel)::utf8, _::bitstring>> = word, consonants), do: <<word::bitstring, consonants::bitstring, "ay">>
  end)

  # Spec case - two word letter, where second letter is y
  defp transform(<<start::utf8, ?y::utf8>>, <<>>), do: <<?y::utf8, start::utf8, "ay">>
  
  defp transform(<<"xr", _::bitstring>> = word, consonants), do: <<word::bitstring, consonants::bitstring, "ay">>
  defp transform(<<"yt", _::bitstring>> = word, consonants), do: <<word::bitstring, consonants::bitstring, "ay">>
  defp transform(<<"qu", rest::bitstring>>, consonants), do: <<rest::bitstring, consonants::bitstring, "quay">>

  Enum.each(@vowels, fn vowel -> 
    defp transform(<<?y::utf8, unquote(vowel)::utf8, rest::bitstring>> = word, consonants), do: transform(<<unquote(vowel)>> <> rest, consonants <> <<?y>>)
    defp transform(<<?x::utf8, unquote(vowel)::utf8, rest::bitstring>> = word, consonants), do: transform(<<unquote(vowel)>> <> rest, consonants <> <<?x>>)
  end)
  defp transform(<<?y::utf8, _::bitstring>> = word, consonants), do: <<word::bitstring, consonants::bitstring, "ay">>
  defp transform(<<?x::utf8, _::bitstring>> = word, consonants), do: <<word::bitstring, consonants::bitstring, "ay">>
  
  defp transform(<<consonant::utf8, rest::bitstring>>, consonants), do: transform(rest, consonants <> <<consonant>>)
end
