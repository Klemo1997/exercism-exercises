defmodule Atbash do
  @encoding Enum.zip(?a..?z, ?z..?a)

  @doc """
  Encode a given plaintext to the corresponding ciphertext

  ## Examples

  iex> Atbash.encode("completely insecure")
  "xlnko vgvob rmhvx fiv"
  """
  @spec encode(String.t()) :: String.t()
  def encode(plaintext, encoded \\ [], i \\ 0)
  def encode(<<>>, encoded, _), do: encoded |> Enum.reverse() |> IO.iodata_to_binary() |> String.trim()
  def encode(plaintext, encoded, 5), do: encode(plaintext, [?\s | encoded], 0)
  Enum.each(@encoding, fn {source, target} -> 
    def encode(<<unquote(source), rest::binary>>, encoded, i), do: encode(rest, [unquote(target) | encoded], i+1)
    def encode(<<unquote(source - (?a-?A)), rest::binary>>, encoded, i), do: encode(rest, [unquote(target) | encoded], i+1)
  end)
  def encode(<<n, rest::binary>>, encoded, i) when n in ?1..?9, do: encode(rest, [n | encoded], i+1)
  def encode(<<_, rest::binary>>, encoded, i), do: encode(rest, encoded, i)
  
  @spec decode(String.t()) :: String.t()
  def decode(cipher, decoded \\ [])
  def decode(<<>>, decoded), do: decoded |> Enum.reverse() |> IO.iodata_to_binary()
  Enum.each(@encoding, fn {source, target} -> 
    def decode(<<unquote(target), rest::binary>>, decoded), do: decode(rest, [unquote(source) | decoded])
  end)
  def decode(<<n, rest::binary>>, decoded) when n in ?1..?9, do: decode(rest, [n | decoded])
  def decode(<<_, rest::binary>>, decoded), do: decode(rest, decoded)
end
