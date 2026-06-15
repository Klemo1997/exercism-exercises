defmodule SecretHandshake do
  import Bitwise

  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code), do: decoded(code)

  defp decoded(code, decoded \\ [])
  defp decoded(0, decoded), do: Enum.reverse(decoded)
  defp decoded(code, decoded) when Bitwise.band(code, 0b00001) > 0, do: decoded(code &&& (~~~0b00001), ["wink" | decoded])
  defp decoded(code, decoded) when Bitwise.band(code, 0b00010) > 0, do: decoded(code &&& (~~~0b00010), ["double blink" | decoded])
  defp decoded(code, decoded) when Bitwise.band(code, 0b00100) > 0, do: decoded(code &&& (~~~0b00100), ["close your eyes" | decoded])
  defp decoded(code, decoded) when Bitwise.band(code, 0b01000) > 0, do: decoded(code &&& (~~~0b01000), ["jump" | decoded])
  defp decoded(code, decoded) when Bitwise.band(code, 0b10000) > 0, do: decoded(code &&& (~~~0b10000), Enum.reverse(decoded))
  defp decoded(code, decoded), do: decoded(code &&& 0b11111, decoded)
end
