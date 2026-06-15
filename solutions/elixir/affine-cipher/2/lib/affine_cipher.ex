defmodule AffineCipher do
  @typedoc """
  A type for the encryption key
  """
  @type key() :: %{a: integer, b: integer}

  @m 26
  @chunk_length 5
 
  @doc """
  Encode an encrypted message using a key
  """
  @spec encode(key :: key(), message :: String.t()) :: {:ok, String.t()} | {:error, String.t()}
  def encode(%{a: a, b: b}, message) do
    cond do
      coprime?(a, @m) -> {:ok, encrypted(message, {a, b})}
      true -> {:error, "a and m must be coprime."}
    end
  end

  defp encrypted(text, config, encrypted \\ <<>>, chunk \\ 0)
  defp encrypted(<<>>, config, <<?\s, encrypted::binary>>, c), do: encrypted(<<>>, config, encrypted, c)
  defp encrypted(<<>>, _, encrypted, _), do: String.reverse(encrypted)
  defp encrypted(text, {a, b}, encrypted, @chunk_length), do: encrypted(text, {a, b}, <<?\s, encrypted::binary>>, 0)
  defp encrypted(<<l, text::binary>>, {a, b}, encrypted, chunk) when l in ?A..?Z, do: encrypted(<<l + (?a - ?A), text::binary>>, {a, b}, encrypted, chunk)
  defp encrypted(<<l, text::binary>>, {a, b}, encrypted, chunk) when l in ?a..?z,
    do: encrypted(text, {a, b}, <<rem(a * (l - ?a) + b, @m) + ?a, encrypted::binary>>, chunk + 1)
  defp encrypted(<<d, text::binary>>, {a, b}, encrypted, chunk) when d in ?0..?9, do: encrypted(text, {a, b}, <<d, encrypted::binary>>, chunk+1)
  defp encrypted(<<_, text::binary>>, {a, b}, encrypted, chunk), do: encrypted(text, {a, b}, encrypted, chunk)

  @doc """
  Decode an encrypted message using a key
  """
  @spec decode(key :: key(), encrypted :: String.t()) :: {:ok, String.t()} | {:error, String.t()}
  def decode(%{a: a, b: b}, encrypted) do
    cond do
      coprime?(a, @m) -> {:ok, decrypted(encrypted, {mmi(a), b})}
      true -> {:error, "a and m must be coprime."}
    end
  end

  defp decrypted(text, config, decrypted \\ <<>>)
  defp decrypted(<<>>, _, decrypted), do: String.reverse(decrypted)
  defp decrypted(<<l, text::binary>>, {mmi_a, b}, decrypted) when l in ?a..?z, 
    do: decrypted(text, {mmi_a, b}, <<rem(rem(mmi_a * (l - ?a - b), @m) + @m, @m) + ?a, decrypted::binary>>)
  defp decrypted(<<d, text::binary>>, config, decrypted) when d in ?0..?9, do: decrypted(text, config, <<d, decrypted::binary>>)
  defp decrypted(<<_, text::binary>>, config, decrypted), do: decrypted(text, config, decrypted)

  defp mmi(a, x \\ 1)
  defp mmi(a, x) when rem(a * x, @m) == 1, do: x
  defp mmi(a, x), do: mmi(a, x + 1)
  
  defp coprime?(a, b), do: Integer.gcd(a, b) == 1
end
