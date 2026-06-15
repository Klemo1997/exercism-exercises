defmodule FoodChain do
  @food_chain [
    {"fly", "I don't know why she swallowed the fly. Perhaps she'll die."},
    {"spider", "It wriggled and jiggled and tickled inside her."},
    {"bird", "How absurd to swallow a bird!"},
    {"cat", "Imagine that, to swallow a cat!"},
    {"dog", "What a hog, to swallow a dog!"},
    {"goat", "Just opened her throat and swallowed a goat!"},
    {"cow", "I don't know how she swallowed a cow!"},
    {"horse", "She's dead, of course!"},
  ]

  @doc """
  Generate consecutive verses of the song 'I Know an Old Lady Who Swallowed a Fly'.
  """
  @spec recite(start :: integer, stop :: integer) :: String.t()
  def recite(start, stop), 
    do: (start - 1)..(stop - 1) 
      |> Enum.map(&verse/1) 
      |> Enum.join("\n\n") 
      |> Kernel.<>("\n")
      
  defp verse(num) when num == 0 or num == 7, 
    do: ["I know an old lady who swallowed a " <> animal(num) <> ".", follow(num)] |> Enum.join("\n")
  defp verse(num), 
    do: Enum.join(["I know an old lady who swallowed a " <> animal(num) <> ".", @food_chain |> Enum.at(num) |> elem(1) | follow(num)], "\n")

  defp follow(0), do: [Enum.at(@food_chain, 0) |> elem(1)]
  defp follow(2), do: ["She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her." | follow(1)]
  defp follow(7), do: [Enum.at(@food_chain, 7) |> elem(1)]
  defp follow(n), do: ["She swallowed the " <> animal(n) <> " to catch the " <> animal(n - 1) <> "." | follow(n - 1)]
  
  defp animal(num), do: Enum.at(@food_chain, num) |> elem(0)
end 
