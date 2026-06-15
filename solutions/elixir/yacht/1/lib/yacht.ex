defmodule Yacht do
  @type category ::
          :ones
          | :twos
          | :threes
          | :fours
          | :fives
          | :sixes
          | :full_house
          | :four_of_a_kind
          | :little_straight
          | :big_straight
          | :choice
          | :yacht

  @doc """
  Calculate the score of 5 dice using the given category's scoring method.
  """
  @spec score(category :: category(), dice :: [integer]) :: integer
  def score(category, [_, _, _, _, _] = dice), 
    do: get_score(category, Enum.sort(dice))

  @category_counts [
    {:ones, 1},
    {:twos, 2},
    {:threes, 3},
    {:fours, 4},
    {:fives, 5},
    {:sixes, 6},
  ]

  Enum.each(@category_counts, fn {category, value} ->
    defp get_score(unquote(category), dice), do: Enum.count(dice, &(&1 == unquote(value))) * unquote(value)
  end)
  
  defp get_score(:full_house, [a, a, a, a, a]), do: 0
  defp get_score(:full_house, [a, a, a, b, b] = dice), do: Enum.sum(dice)
  defp get_score(:full_house, [a, a, b, b, b] = dice), do: Enum.sum(dice)
  defp get_score(:full_house, _), do: 0

  defp get_score(:four_of_a_kind, [a, a, a, a, _]), do: 4 * a
  defp get_score(:four_of_a_kind, [_, a, a, a, a]), do: 4 * a
  defp get_score(:four_of_a_kind, _), do: 0

  defp get_score(:little_straight, [1, 2, 3, 4, 5]), do: 30
  defp get_score(:little_straight, _), do: 0

  defp get_score(:big_straight, [2, 3, 4, 5, 6]), do: 30
  defp get_score(:big_straight, _), do: 0

  defp get_score(:choice, dice), do: Enum.sum(dice)
  
  defp get_score(:yacht, [a, a, a, a, a]), do: 50
  defp get_score(:yacht, [_, _, _, _, _]), do: 0
end
