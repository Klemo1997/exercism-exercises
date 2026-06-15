defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidates),
    do: String.downcase(base)
      |> then(fn downcase_base ->
        Enum.filter(candidates, &same_length?(base, &1))
        |> Enum.filter(&anagram?(downcase_base, String.downcase(&1)))
      end)

  defp same_length?(str, other_str), do: String.length(str) === String.length(other_str)

  defp anagram?(base, base), do: false
  defp anagram?(base, candidate), do: normalize(base) === normalize(candidate)

  defp normalize(string),
    do: string
      |> String.to_charlist()
      |> Enum.sort()
end