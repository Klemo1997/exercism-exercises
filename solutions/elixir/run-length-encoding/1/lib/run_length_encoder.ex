defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"
  """
  @spec encode(String.t()) :: String.t()
  def encode(string) when is_binary(string),
    do: string
      |> compress()

  defp compress(<<>>), do: <<>>
  defp compress(<<c, rest::binary>>), do: compress(rest, <<>>, c, 1)
  defp compress(<<c, rest::binary>>, acc, c, repeated), do: compress(rest, acc, c, repeated + 1)
  defp compress(<<c, rest::binary>>, acc, last_c, repeated), do: compress(rest, acc <> shrink(last_c, repeated), c, 1)
  defp compress(<<>>, acc, last_c, repeated), do: acc <> shrink(last_c, repeated)

  defp shrink(c, 1), do: <<c>>
  defp shrink(c, repeated), do: Integer.to_string(repeated) <> <<c>> 

  @spec decode(String.t()) :: String.t()
  def decode(string) when is_binary(string), 
    do: string
      |> decompress()

  defp decompress(string, acc \\ <<>>, digits \\ <<>>)
  defp decompress(<<>>, acc, <<>>), do: acc
  defp decompress(<<digit, rest::binary>>, acc, digits) when digit in ?0..?9, do: decompress(rest, acc, digits <> <<digit>>)
  defp decompress(<<c, rest::binary>>, acc, digits), do: decompress(rest, acc <> expand(c, digits))

  defp expand(c, <<>>), do: <<c>>
  defp expand(c, digits), do: String.duplicate(<<c>>, String.to_integer(digits))
end
