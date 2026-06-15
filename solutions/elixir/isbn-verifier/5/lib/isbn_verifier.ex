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
  def isbn?(isbn), do: correct?(isbn, 0, 10)

  defp correct?(<<>>, sum, 0), do: rem(sum, 11) === 0
  defp correct?(<<>>, sum, _), do: false
  defp correct?(<<?X>>, sum, m), do: correct?(<<>>, sum + 10, m-1)
  defp correct?(<<?-, rest::binary>>, sum, m), do: correct?(rest, sum, m)
  defp correct?(<<d, rest::binary>>, sum, m) when d in ?0..?9, do: correct?(rest, sum + (d-?0)*m, m-1)
  defp correct?(_, _, _), do: false
end
