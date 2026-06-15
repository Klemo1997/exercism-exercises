defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidates) do
    downcase_base = String.downcase(base)
    freq_map = freq_map(downcase_base)
    candidates
    |> Stream.map(fn candidate -> {candidate, String.downcase(candidate)} end)
    |> Stream.filter(fn {_, downcase_candidate} -> downcase_candidate !== downcase_base end)
    |> Stream.filter(fn {_, downcase_candidate} -> freq_map(downcase_candidate) === freq_map end)
    |> Stream.map(fn {candidate, _} -> candidate end)
    |> Enum.to_list
  end

  defp freq_map(string), 
    do: String.to_charlist(string)
    |> Enum.reduce(%{}, fn char, freq_map -> Map.update(freq_map, char, 1, &(&1 + 1)) end)
end
