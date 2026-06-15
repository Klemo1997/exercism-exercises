defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift), 
    do: cipher(text, shift)
      |> Enum.reverse()
      |> IO.iodata_to_binary

  defp cipher(text, shift, cipher \\ [])
  defp cipher(<<>>, _, cipher), do: cipher
  defp cipher(<<c, rest::binary>>, shift, cipher), 
    do: cipher(rest, shift, [encoded(c, shift) | cipher])

  defp encoded(c, shift) when c in ?a..?z, do: rem(c - ?a + shift, ?z-?a+1) + ?a
  defp encoded(c, shift) when c in ?A..?Z, do: rem(c - ?A + shift, ?Z-?A+1) + ?A
  defp encoded(c, _), do: c
end
