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
  def score(word) when is_binary(word), do: score(word, 0)
  defp score(<<>>, cumulative_score), do: cumulative_score
  defp score(<<l, rest::binary>>, cumulative_score), do: score(rest, cumulative_score + points(l))

  for {letters, points} <- @letter_points, letter <- letters do
    defp points(unquote(letter)), do: unquote(points)
    defp points(unquote(letter+32)), do: unquote(points)
  end
  defp points(_invalid_letter), do: 0
end
