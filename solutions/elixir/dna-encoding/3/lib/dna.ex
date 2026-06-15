defmodule DNA do
  @spec encode_nucleotide(char()) :: pos_integer()
  def encode_nucleotide(code_point) do
    case code_point do
      ?A -> 0b0001
      ?C -> 0b0010
      ?G -> 0b0100
      ?T -> 0b1000
      ?\s  -> 0b0000
    end
  end
  
@spec decode_nucleotide(pos_integer()) :: char()
  def decode_nucleotide(encoded_code) do
    case encoded_code do
      0b0001 -> ?A
      0b0010 -> ?C
      0b0100 -> ?G
      0b1000 -> ?T
      0b0000 -> ?\s
    end
  end

  @spec encode(charlist()) :: bitstring()
  def encode(dna), do: do_encode(dna, <<>>)

  @spec do_encode(charlist(), bitstring()) :: bitstring()
  def do_encode([], acc), do: acc
  def do_encode([head | tail], acc), do: do_encode(tail, << acc::bitstring, encode_nucleotide(head)::size(4) >>)

  @spec decode(bitstring()) :: charlist()
  def decode(dna), do: do_decode(dna, [])

  @spec do_decode(bitstring(), charlist()) :: charlist()
  def do_decode(<<>>, acc), do: acc
  def do_decode(<<head::size(4), tail::bitstring>>, acc), do: do_decode(tail, acc ++ [decode_nucleotide(head)])
end
