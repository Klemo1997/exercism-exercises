defmodule StringSeries do
  @doc """
  Given a string `s` and a positive integer `size`, return all substrings
  of that size. If `size` is greater than the length of `s`, or less than 1,
  return an empty list.
  """
  @spec slices(s :: String.t(), size :: integer) :: list(String.t())
  def slices(s, size), do: sliced(s, size)

  defp sliced(s, size, slices \\ [])
  defp sliced(s, size, slices) when size < 1, do: []
  defp sliced(<<>>, size, slices), do: Enum.reverse(slices)
  defp sliced(<<c::utf8, rest::binary>> = s, size, slices) do
    cond do 
      String.length(s) < size -> Enum.reverse(slices)
      true -> sliced(rest, size, [String.slice(s, 0, size) | slices])
    end
  end
end
