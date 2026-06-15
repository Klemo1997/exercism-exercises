defmodule Proverb do
  @doc """
  Generate a proverb from a list of strings.
  """
  @spec recite(strings :: [String.t()]) :: String.t()
  def recite([]), do: ""
  def recite([first | _] = strings), 
    do: ["And all for the want of a #{first}.\n" | verses(strings)]
      |> Enum.reverse()
      |> Enum.join("")

  def verses(words, verses \\ [])
  def verses([first, second | rest], verses), do: verses([second | rest], ["For want of a #{first} the #{second} was lost.\n" | verses])
  def verses(_, verses), do: verses
end