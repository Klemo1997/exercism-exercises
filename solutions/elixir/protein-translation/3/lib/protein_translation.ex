defmodule ProteinTranslation do
  @codon_protein_pairs [
    {"UGU", "Cysteine"},
    {"UGC", "Cysteine"},
    {"UUA", "Leucine"},
    {"UUG", "Leucine"},
    {"AUG", "Methionine"},
    {"UUU", "Phenylalanine"},
    {"UUC", "Phenylalanine"},
    {"UCU", "Serine"},
    {"UCC", "Serine"},
    {"UCA", "Serine"},
    {"UCG", "Serine"},
    {"UGG", "Tryptophan"},
    {"UAU", "Tyrosine"},
    {"UAC", "Tyrosine"},
  ]

  @stop_codons [
      "UAA", 
      "UAG", 
      "UGA",
  ]

  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: {:ok, list(String.t())} | {:error, String.t()}
  def of_rna(rna), do: translated(rna, [])

  defp translated(<<>>, list), do: {:ok, Enum.reverse(list)} 
  Enum.each(@codon_protein_pairs, fn {codon, protein} -> 
    defp translated(<<unquote(codon), rest::binary>>, list), do: translated(rest, [unquote(protein) | list])
  end)
  Enum.each(@stop_codons, fn codon -> 
    defp translated(<<unquote(codon), _::binary>>, list), do: {:ok, Enum.reverse(list)}
  end)
  defp translated(_, _), do: {:error, "invalid RNA"}

  @doc """
  Given a codon, return the corresponding protein
  """
  @spec of_codon(String.t()) :: {:ok, String.t()} | {:error, String.t()}
  Enum.each(@codon_protein_pairs, fn {codon, protein} -> 
    def of_codon(unquote(codon)), do: {:ok, unquote(protein)}
  end)
  Enum.each(@stop_codons, fn codon -> 
    def of_codon(unquote(codon)), do: {:ok, "STOP"}
  end)
  def of_codon(_), do: {:error, "invalid codon"}
end
