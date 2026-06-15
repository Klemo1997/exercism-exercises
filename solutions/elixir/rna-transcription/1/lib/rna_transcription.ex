defmodule RnaTranscription do
  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

    iex> RnaTranscription.to_rna(~c"ACTG")
    ~c"UGAC"
  """
  @spec to_rna([char]) :: [char]
  def to_rna(dna), do: Enum.reverse(to_rna(dna, []))

  defp to_rna([], rna), do: rna
  defp to_rna([nucleotide | dna], rna), do: to_rna(dna, [complement(nucleotide) | rna])

  defp complement(?G), do: ?C
  defp complement(?C), do: ?G
  defp complement(?T), do: ?A
  defp complement(?A), do: ?U
end
