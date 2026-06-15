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
  def encode(dna), do: do_encode(dna, <<>>)

  @spec do_encode(charlist(), bitstring()) :: bitstring()
  defp do_encode([], acc), do: acc
  defp do_encode([head | tail], acc), do: do_encode(tail, << acc::bitstring, encode_nucleotide(head)::size(4) >>)

  @spec decode(bitstring()) :: charlist()
  def decode(dna), do: do_decode(dna, [])

  @spec do_decode(bitstring(), charlist()) :: charlist()
  defp do_decode(<<>>, acc), do: acc
  defp do_decode(<<head::size(4), tail::bitstring>>, acc), do: do_decode(tail, acc ++ [decode_nucleotide(head)])
end
