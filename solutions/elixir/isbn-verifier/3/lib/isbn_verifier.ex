defmodule IsbnVerifier do
  @doc """
    Checks if a string is a valid ISBN-10 identifier

    ## Examples

      iex> IsbnVerifier.isbn?("3-598-21507-X")
      true

      iex> IsbnVerifier.isbn?("3-598-2K507-0")
      false

  """
  @spec isbn?(String.t()) :: boolean
  def isbn?(isbn), do: isbn?(isbn, [])
  defp isbn?(<<>>, digits), do: digit_sum(digits) === 0
  defp isbn?(<<?X>>, digits), do: isbn?(<<>>, [10 | digits])
  defp isbn?(<<?-, rest::binary>>, digits), do: isbn?(rest, digits)
  defp isbn?(<<d, rest::binary>>, digits) when d in ?0..?9, do: isbn?(rest, [d-?0 | digits])
  defp isbn?(_, _), do: false

  defp digit_sum([d10, d9, d8, d7, d6, d5, d4, d3, d2, d1] = digits), 
    do: rem(d1*10 + d2*9 + d3*8 + d4*7 + d5*6 + d6*5 + d7*4 + d8*3 + d9*2 + d10, 11)
  defp digit_sum(_), do: -1
end
