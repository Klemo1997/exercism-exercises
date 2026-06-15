defmodule LineUp do
  @doc """
  Formats a full ticket sentence for the given name and number, including
  the person's name, the ordinal form of the number, and fixed descriptive text.
  """
  @spec format(name :: String.t(), number :: pos_integer()) :: String.t()
  def format(name, number) do
    "#{name}, you are the #{number}#{ordinal(number)} customer we serve today. Thank you!"
  end

  defp ordinal(n) when n > 100, do: ordinal(rem(n, 100))
  defp ordinal(11), do: "th"
  defp ordinal(12), do: "th"
  defp ordinal(13), do: "th"
  defp ordinal(n) when rem(n, 10) == 1, do: "st"
  defp ordinal(n) when rem(n, 10) == 2, do: "nd"
  defp ordinal(n) when rem(n, 10) == 3, do: "rd"
  defp ordinal(_), do: "th"
end
