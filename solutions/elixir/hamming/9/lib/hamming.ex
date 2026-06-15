defmodule Hamming do
  @doc """
  Returns number of differences between two strands of DNA, known as the Hamming Distance.

  ## Examples

  iex> Hamming.hamming_distance(~c"AAGTCATA", ~c"TAGCGATC")
  {:ok, 4}
  """

  @inequal_strands_err {:error, "strands must be of equal length"}
  
  @spec hamming_distance([char], [char]) :: {:ok, non_neg_integer} | {:error, String.t()}
  def hamming_distance(strand1, strand2), do: count_non_matching_pairs(strand1, strand2, 0)

  defp count_non_matching_pairs([char | strand1], [char | strand2], distance), do: count_non_matching_pairs(strand1, strand2, distance)
  defp count_non_matching_pairs([_ | strand1], [_ | strand2], distance), do: count_non_matching_pairs(strand1, strand2, distance + 1)
  defp count_non_matching_pairs([], [], distance), do: {:ok, distance}
  defp count_non_matching_pairs([], _, _), do: @inequal_strands_err
  defp count_non_matching_pairs(_, [], _), do: @inequal_strands_err
end