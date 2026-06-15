defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidates),
    do: Enum.filter(candidates, &anagram?(String.downcase(base), String.downcase(&1)))

  defp anagram?(base, base), do: false
  defp anagram?(base, candidate), do: normalize(base) === normalize(candidate)

  defp normalize(string),
    do: string
      |> String.to_charlist()
      |> Enum.sort()
end
