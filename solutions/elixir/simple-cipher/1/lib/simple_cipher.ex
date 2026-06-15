defmodule SimpleCipher do
  @doc """
  Given a `plaintext` and `key`, encode each character of the `plaintext` by
  shifting it by the corresponding letter in the alphabet shifted by the number
  of letters represented by the `key` character, repeating the `key` if it is
  shorter than the `plaintext`.

  For example, for the letter 'd', the alphabet is rotated to become:

  defghijklmnopqrstuvwxyzabc

  You would encode the `plaintext` by taking the current letter and mapping it
  to the letter in the same position in this rotated alphabet.

  abcdefghijklmnopqrstuvwxyz
  defghijklmnopqrstuvwxyzabc

  "a" becomes "d", "t" becomes "w", etc...

  Each letter in the `plaintext` will be encoded with the alphabet of the `key`
  character in the same position. If the `key` is shorter than the `plaintext`,
  repeat the `key`.

  Example:

  plaintext = "testing"
  key = "abc"

  The key should repeat to become the same length as the text, becoming
  "abcabca". If the key is longer than the text, only use as many letters of it
  as are necessary.
  """
  def encode(plaintext, key), do: encode(plaintext, key, <<>>, key)
  defp encode(<<c, plaintext::binary>>, <<k, key::binary>>, encoded, orig_key), do: encode(plaintext, key, encoded <> <<rem(c+(k-?a)-?a, ?z-?a+1) + ?a>>, orig_key)
  defp encode(plaintext, <<>>, encoded, orig_key), do: encode(plaintext, orig_key, encoded, orig_key)
  defp encode(<<>>, _, encoded, _), do: encoded

  @doc """
  Given a `ciphertext` and `key`, decode each character of the `ciphertext` by
  finding the corresponding letter in the alphabet shifted by the number of
  letters represented by the `key` character, repeating the `key` if it is
  shorter than the `ciphertext`.

  The same rules for key length and shifted alphabets apply as in `encode/2`,
  but you will go the opposite way, so "d" becomes "a", "w" becomes "t",
  etc..., depending on how much you shift the alphabet.
  """
  def decode(ciphertext, key), do: decode(ciphertext, key, <<>>, key)
  defp decode(<<c, ciphertext::binary>>, <<k, key::binary>>, decoded, orig_key), do: decode(ciphertext, key, decoded <> <<rem((c - ?a) - (k - ?a) + (?z-?a+1), (?z-?a+1)) + ?a>>, orig_key)
  defp decode(ciphertext, <<>>, decoded, orig_key), do: decode(ciphertext, orig_key, decoded, orig_key)
  defp decode(<<>>, _, decoded, _), do: decoded

  @doc """
  Generate a random key of a given length. It should contain lowercase letters only.
  """
  def generate_key(length),
    do: (for _ <- 1..length, do: Enum.random(?a..?z))
    |> IO.iodata_to_binary()
end
