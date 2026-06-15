defmodule NucleotideCount do
  @nucleotides [?A, ?C, ?G, ?T]

  @doc """
  Counts individual nucleotides in a DNA strand.

  ## Examples

  iex> NucleotideCount.count(~c"AATAA", ?A)
  4

  iex> NucleotideCount.count(~c"AATAA", ?T)
  1
  """
  @spec count(charlist(), char()) :: non_neg_integer()
  def count(strand, nucleotide, count \\ 0)
  def count([c | strand], c, count), do: count(strand, c, count + 1)
  def count([_ | strand], c, count), do: count(strand, c, count)
  def count([], c, count), do: count

  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples

  iex> NucleotideCount.histogram(~c"AATAA")
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """
  @spec histogram(charlist()) :: map()
  def histogram(strand, counts \\ %{?A => 0, ?T => 0, ?C => 0, ?G => 0})
  def histogram([c | strand], counts), do: histogram(strand, Map.update!(counts, c, &(&1 + 1)))
  def histogram([], counts), do: counts
end
