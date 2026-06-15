defmodule Hamming do
  @doc """
  Returns number of differences between two strands of DNA, known as the Hamming Distance.

  ## Examples

  iex> Hamming.hamming_distance(~c"AAGTCATA", ~c"TAGCGATC")
  {:ok, 4}
  """

  @inequal_strands_err {:error, "strands must be of equal length"}
  
  @spec hamming_distance([char], [char]) :: {:ok, non_neg_integer} | {:error, String.t()}
  def hamming_distance(strand1, strand2, distance \\ 0)
  def hamming_distance([char | strand1], [char | strand2], distance), do: hamming_distance(strand1, strand2, distance)
  def hamming_distance([_ | strand1], [_ | strand2], distance), do: hamming_distance(strand1, strand2, distance + 1)
  def hamming_distance([], [], distance), do: {:ok, distance}
  def hamming_distance([], _, _), do: @inequal_strands_err
  def hamming_distance(_, [], _), do: @inequal_strands_err
end