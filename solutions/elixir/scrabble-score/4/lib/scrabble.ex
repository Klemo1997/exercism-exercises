defmodule Scrabble do
  @letter_points [
    {~c(AEIOULNRST), 1},
    {~c(DG), 2},
    {~c(BCMP), 3},
    {~c(FHVWY), 4},
    {~c(K), 5},
    {~c(JX), 8},
    {~c(QZ), 10},
  ]

  @doc """
  Calculate the scrabble score for the word.
  """
  @spec score(String.t()) :: non_neg_integer
  def score(word) when is_binary(word), do: points(word)
  
  defp points(letter, total \\ 0)
  defp points(<<>>, total), do: total
  for {letters, p} <- @letter_points, uppercase when uppercase in ?A..?Z <- letters, lowercase = ?a + uppercase - ?A do
    defp points(<<unquote(uppercase), rest::binary>>, total), do: points(rest, total + unquote(p))
    defp points(<<unquote(lowercase), rest::binary>>, total), do: points(rest, total + unquote(p))
  end
  defp points(<<_invalid_letter, rest::binary>>, total), do: points(rest, total)
end
