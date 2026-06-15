defmodule Hamming do
  @doc """
  Returns number of differences between two strands of DNA, known as the Hamming Distance.

  ## Examples

  iex> Hamming.hamming_distance(~c"AAGTCATA", ~c"TAGCGATC")
  {:ok, 4}
  """

  @inequal_strands_err {:error, "strands must be of equal length"}
  
  @spec hamming_distance([char], [char]) :: {:ok, non_neg_integer} | {:error, String.t()}
  def hamming_distance(strand1, strand2), do: hamming_distance(strand1, strand2, 0)

  defp hamming_distance([], [], distance), do: {:ok, distance}
  defp hamming_distance([], _, _), do: @inequal_strands_err
  defp hamming_distance(_, [], _), do: @inequal_strands_err
  defp hamming_distance([char | strand1], [char | strand2], distance), do: hamming_distance(strand1, strand2, distance)
  defp hamming_distance([_ | strand1], [_ | strand2], distance), do: hamming_distance(strand1, strand2, distance + 1)
end