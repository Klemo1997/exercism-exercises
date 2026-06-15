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

  def shifted(text, shift, cipher \\ [])
  def shifted(<<>>, _, cipher), do: cipher
  def shifted(<<c, rest::binary>>, shift, cipher) when c in ?a..?z, 
    do: shifted(rest, shift, [rem(c - ?a + shift, 26) + ?a | cipher])
  def shifted(<<c, rest::binary>>, shift, cipher) when c in ?A..?Z, 
    do: shifted(rest, shift, [rem(c - ?A + shift, 26) + ?A | cipher])
  def shifted(<<c, rest::binary>>, shift, cipher), 
    do: shifted(rest, shift, [c | cipher])
end
