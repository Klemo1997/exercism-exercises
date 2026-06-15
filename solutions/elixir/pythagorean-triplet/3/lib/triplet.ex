defmodule Triplet do
  defguardp pythagorean_triplet?(a, b, c) when a*a + b*b == c*c

  @doc """
  Calculates sum of a given triplet of integers.
  """
  @spec sum([non_neg_integer]) :: non_neg_integer
  def sum([a, b, c]), do: a + b + c

  @doc """
  Calculates product of a given triplet of integers.
  """
  @spec product([non_neg_integer]) :: non_neg_integer
  def product([a, b, c]), do: a * b * c

  @doc """
  Determines if a given triplet is pythagorean. That is, do the squares of a and b add up to the square of c?
  """
  @spec pythagorean?([non_neg_integer]) :: boolean
  def pythagorean?([a, b, c]) when pythagorean_triplet?(a, b, c), do: true
  def pythagorean?([_, _, _]), do: false

  @doc """
  Generates a list of pythagorean triplets whose values add up to a given sum.
  """
  @spec generate(non_neg_integer) :: [list(non_neg_integer)]
  def generate(sum),
    do: generate(sum, 3, [], []) 
      |> Enum.reverse()

  defp generate(0, 0, [a, b, c] = seq, sequences) when pythagorean_triplet?(a, b, c), do: [seq | sequences]
  defp generate(_, 0, _, sequences), do: sequences
  defp generate(0, _, _, sequences), do: sequences
  defp generate(rem, steps, seq, sequences) do
     max = min(rem - (steps - 1), List.first(seq, rem))
     min = steps

     for i <- max..min, reduce: sequences do
       sequences -> generate(rem - i, steps - 1, [i | seq], sequences)
     end
  end
end
