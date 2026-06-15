defmodule Transmission do
  @doc """
  Return the transmission sequence for a message.
  """
  @spec get_transmit_sequence(binary()) :: binary()
  def get_transmit_sequence(message, sequence \\ [])
  def get_transmit_sequence(<<chunk::7, message::bitstring>>, sequence) do
    parity_bit = rem(bit_count(<<chunk::7>>), 2)
    get_transmit_sequence(message, [<<chunk::7, parity_bit::1>> | sequence])
  end
  def get_transmit_sequence(<<>>, sequence), do: Enum.reverse(sequence) |> :binary.list_to_bin()
  def get_transmit_sequence(short_chunk, sequence),
    do: get_transmit_sequence(bit_zero_padding(short_chunk, 7), sequence)

  @doc """
  Return the message decoded from the received transmission.
  """
  @spec decode_message(binary()) :: {:ok, binary()} | {:error, String.t()}
  def decode_message(message, decoded \\ <<>>)
  def decode_message(<<chunk::7, parity_bit::1, message::bitstring>>, decoded) do
    cond do
      parity_bit == rem(bit_count(<<chunk::7>>), 2) ->
        decode_message(message, <<decoded::bitstring, chunk::7>>)
      true -> {:error, "wrong parity"}
    end
  end
  def decode_message(<<>>, decoded) do
    bytes = div(bit_size(decoded), 8)
    <<decoded::binary-size(bytes), _padding::bitstring>> = decoded
    {:ok, decoded}
  end

  defp bit_count(chunk, bit_count \\ 0)
  defp bit_count(<<1::1, sequence::bitstring>>, bit_count), do: bit_count(sequence, bit_count + 1)
  defp bit_count(<<0::1, sequence::bitstring>>, bit_count), do: bit_count(sequence, bit_count)
  defp bit_count(<<>>, bit_count), do: bit_count

  defp bit_zero_padding(chunk, length) when rem(bit_size(chunk), length) != 0, 
    do: <<chunk::bitstring, 0::size(length - rem(bit_size(chunk), length))>>
  defp bit_zero_padding(chunk, _), do: chunk
end
