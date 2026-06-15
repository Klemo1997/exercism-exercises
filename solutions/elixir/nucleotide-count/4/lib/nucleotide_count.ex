defmodule NucleotideCount do
  @doc """
  Counts individual nucleotides in a DNA strand.

  ## Examples

  iex> NucleotideCount.count(~c"AATAA", ?A)
  4

  iex> NucleotideCount.count(~c"AATAA", ?T)
  1
  """
  @spec count(charlist(), char()) :: non_neg_integer()
  def count(strand, nucleotide), do: Enum.count(strand, &(&1 === nucleotide))

  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples

  iex> NucleotideCount.histogram(~c"AATAA")
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """
  @spec histogram(charlist()) :: map()
  def histogram(strand), 
    do: Enum.reduce(
      strand,
      %{?A => 0, ?T => 0, ?C => 0, ?G => 0},
      fn c, counts -> Map.update!(counts, c, &(&1 + 1)) end)
end
