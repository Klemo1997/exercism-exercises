defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift), 
    do: shifted(text, shift)
      |> Enum.reverse()
      |> IO.iodata_to_binary

  defp shifted(text, shift, cipher \\ [])
  defp shifted(<<>>, _, cipher), do: cipher
  defp shifted(<<c, rest::binary>>, shift, cipher), 
    do: shifted(rest, shift, [encode(c, shift) | cipher])

  defp encode(c, shift) when c in ?a..?z, do: rem(c - ?a + shift, ?z-?a+1) + ?a
  defp encode(c, shift) when c in ?A..?Z, do: rem(c - ?A + shift, ?Z-?A+1) + ?A
  defp encode(c, _), do: c
end
