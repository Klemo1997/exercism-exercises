defmodule WordCount do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    sentence
    |> String.split(~r/[\s_,!&@$%^:.]+/, trim: true)
    |> Enum.map(&sanitize/1)
    |> Enum.frequencies()
  end

  defp sanitize(word),
    do: word
      |> String.trim("'")
      |> String.downcase()
end
