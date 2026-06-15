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
    do: encoded(string)

  defp encoded(string, encoded \\ [])
  defp encoded(<<>>, encoded), 
    do: Enum.reduce(encoded, [], fn
        {c, 1}, acc -> [c | acc]
        {c, n}, acc -> [Integer.to_string(n), c | acc]
      end)
      |> IO.iodata_to_binary()
  defp encoded(<<c, rest::binary>>, [{c, n} | encoded]), do: encoded(rest, [{c, n+1} | encoded])
  defp encoded(<<c, rest::binary>>, encoded), do: encoded(rest, [{c, 1} | encoded])

  @spec decode(String.t()) :: String.t()
  def decode(string) when is_binary(string),
    do: decoded(string)

  defp decoded(string, decoded \\ [])
  defp decoded(<<>>, decoded), 
    do: Enum.reverse(decoded)
      |> IO.iodata_to_binary()
  defp decoded(<<maybe_c, maybe_rest::binary>> = string, decoded),
      do: Integer.parse(string)
        |> then(fn
          {repeated, <<c, rest::binary>>} -> decoded(rest, [String.duplicate(<<c>>, repeated) | decoded])
          _ -> decoded(maybe_rest, [maybe_c | decoded])
         end)
end
