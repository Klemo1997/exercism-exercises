defmodule DNA do
  def encode_nucleotide(code_point) do
    case code_point do
      ?A -> 0b0001
      ?C -> 0b0010
      ?G -> 0b0100
      ?T -> 0b1000
      ?\s -> 0b0000
      _ -> raise("Oops!")
    end
  end

  def decode_nucleotide(encoded_code) do
    case encoded_code do
      0b0001 -> ?A
      0b0010 -> ?C
      0b0100 -> ?G
      0b1000 -> ?T
      0b0000 -> ?\s
      _ -> raise("Oops!")
    end
  end

  def encode([head | rest]) do
    << encode_nucleotide(head)::4, encode(rest)::bitstring >>
  end

  def encode([]), do: <<0::0>>

  def decode(<<value::4, rest::bitstring>>) do
    [decode_nucleotide(value)] ++ decode(rest)
  end

  def decode(<<>>), do: []
end
