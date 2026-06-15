defmodule DNA do
  @nucleotides_and_codes [
    {?\s, 0b0000},
    {?A, 0b0001},
    {?C, 0b0010},
    {?G, 0b0100},
    {?T, 0b1000},
  ]
  
  @spec encode_nucleotide(char()) :: pos_integer()
  Enum.each(@nucleotides_and_codes, fn {nucleotide, code} -> 
    def encode_nucleotide(unquote(nucleotide)), do: unquote(code)
  end)

  @spec decode_nucleotide(pos_integer()) :: char()
  Enum.each(@nucleotides_and_codes, fn {nucleotide, code} ->
    def decode_nucleotide(unquote(code)), do: unquote(nucleotide)
  end)

  @spec encode(charlist()) :: bitstring()
  def encode(dna), do: encode(dna, <<>>)

  @spec encode(charlist(), bitstring()) :: bitstring()
  defp encode([], encoded), do: encoded
  defp encode([nucleotide | dna], encoded), 
    do: encode(dna, << encoded::bitstring, encode_nucleotide(nucleotide)::size(4) >>)

  @spec decode(bitstring()) :: charlist()
  def decode(dna), do: decode(dna, [])

  @spec decode(bitstring(), charlist()) :: charlist()
  defp decode(<<>>, decoded), do: Enum.reverse(decoded)
  defp decode(<<encoded_nucleotide::size(4), encoded::bitstring>>, decoded), 
    do: decode(encoded, [decode_nucleotide(encoded_nucleotide) | decoded])
end
