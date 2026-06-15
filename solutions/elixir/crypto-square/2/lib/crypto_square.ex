defmodule CryptoSquare do
  @doc """
  Encode string square methods
  ## Examples

    iex> CryptoSquare.encode("abcd")
    "ac bd"
  """
  @spec encode(String.t()) :: String.t()
  def encode(str) do
    {sanitized, len} = sanitized(str)
    c = Enum.find(1..len, &(&1**2 >= len)) 
    r = if(rem(len, c) == 0, do: div(len, c), else: div(len, c) + 1)
    trailing_pad = String.duplicate(" ", c*r-len)
    encoded(sanitized <> trailing_pad, {r, c})
  end

  defp sanitized(input, sanitized \\ <<>>, len \\ 0)
  defp sanitized(<<>>, sanitized, len), do: {sanitized, len}
  defp sanitized(<<c, rest::binary>>, sanitized, len) when c in ?A..?Z, do: sanitized(rest, <<sanitized::binary, c + 32>>, len + 1)
  defp sanitized(<<c, rest::binary>>, sanitized, len) when c in ?a..?z or c in ?0..?9, do: sanitized(rest, <<sanitized::binary, c>>, len + 1)
  defp sanitized(<<_, rest::binary>>, sanitized, len), do: sanitized(rest, sanitized, len)

  defp encoded(input, dim, i \\ 0, encoded \\ <<>>)
  defp encoded(input, {r, c}, _, _) when r*c <= 1, do: input
  defp encoded(input, {r, c}, i, encoded) when r*c == i, do: encoded
  defp encoded(input, {r, c}, i, encoded) when i > 0 and rem(i, r) == 0, do: encoded(input, {r, c}, i+1, <<encoded::binary, ?\s, :binary.at(input, translate(r, c, i))>>)
  defp encoded(input, {r, c}, i, encoded), do: encoded(input, {r, c}, i+1, <<encoded::binary, :binary.at(input, translate(r, c, i))>>)

  defp translate(r, c, i) do
    rem(i, r)*c+div(i, r)
  end
end
