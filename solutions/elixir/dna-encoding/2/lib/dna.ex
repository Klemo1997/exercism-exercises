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
  def encode([]), do: <<>>
  def encode([head | tail]), do: <<encode_nucleotide(head)::size(4), encode(tail)::bitstring>>

  @spec decode(bitstring()) :: charlist()
  def decode(<<>>), do: []
  def decode(<<head::size(4), tail::bitstring>>), do: [decode_nucleotide(head) | decode(tail)]
end
