defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidates) do
    downcase_base = String.downcase(base)
    freq_map = freq_map(downcase_base)
    Enum.filter(candidates, fn candidate -> 
      String.downcase(candidate)
      |> then(fn downcase_candidate ->
        freq_map(downcase_candidate) === freq_map
        and downcase_candidate !== downcase_base
      end)
    end)
  end

  def freq_map(string) do
    String.to_charlist(string)
    |> Enum.reduce(%{}, fn char, freq_map -> Map.update(freq_map, char, 1, &(&1 + 1)) end)
  end
end
