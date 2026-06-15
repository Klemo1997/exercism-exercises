defmodule Hamming do
  @doc """
  Returns number of differences between two strands of DNA, known as the Hamming Distance.

  ## Examples

  iex> Hamming.hamming_distance(~c"AAGTCATA", ~c"TAGCGATC")
  {:ok, 4}
  """
  @spec hamming_distance([char], [char]) :: {:ok, non_neg_integer} | {:error, String.t()}
  def hamming_distance(strand1, strand2) do 
    cond do
      Enum.count(strand1) != Enum.count(strand2) -> {:error, "strands must be of equal length"}
      true -> {:ok, distance(strand1, strand2)}
    end
  end

  defp distance([], []), do: 0
  defp distance([char | strand1], [char | strand2]), do: distance(strand1, strand2)
  defp distance([_ | strand1], [_ | strand2]), do: 1 + distance(strand1, strand2)
end
