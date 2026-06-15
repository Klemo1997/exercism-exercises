defmodule MatchingBrackets do
  @bracket_pairs [
    ~c(\(\)),
    ~c([]),
    ~c({}),
  ]

  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @spec check_brackets(String.t()) :: boolean
  def check_brackets(str), do: enclosed_brackets?(str)

  defp enclosed_brackets?(str, brackets \\ [])
  Enum.each(@bracket_pairs, fn [opening, enclosing] -> 
    defp enclosed_brackets?(<<unquote(opening), rest::binary>>, brackets), do: enclosed_brackets?(rest, [unquote(opening) | brackets])
    defp enclosed_brackets?(<<unquote(enclosing), rest::binary>>, [unquote(opening) | brackets]), do: enclosed_brackets?(rest, brackets)
    defp enclosed_brackets?(<<unquote(enclosing), _::binary>>, _), do: false
  end)
  defp enclosed_brackets?(<<_, rest::binary>>, brackets), do: enclosed_brackets?(rest, brackets)
  defp enclosed_brackets?(<<>>, []), do: true
  defp enclosed_brackets?(<<>>, _), do: false
end
