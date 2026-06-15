defmodule BottleSong do
  @numbers %{
    10 => "ten",
    9 => "nine",
    8 => "eight",
    7 => "seven",
    6 => "six",
    5 => "five",
    4 => "four",
    3 => "three",
    2 => "two",
    1 => "one",
    0 => "no",
  }

  @moduledoc """
  Handles lyrics of the popular children song: Ten Green Bottles
  """

  @spec recite(pos_integer, pos_integer) :: String.t()
  def recite(number, take_down, verses \\ [])
  def recite(_, 0, verses), 
    do: verses |> Enum.reverse() |> Enum.join("\n\n")
  def recite(number, take_down, verses),
    do: with(
        bottles <- bottles(number) |> String.capitalize(),
        next_bottles <- bottles(number-1),
        verse <- """
          #{bottles} hanging on the wall,
          #{bottles} hanging on the wall,
          And if one green bottle should accidentally fall,
          There'll be #{next_bottles} hanging on the wall.\
          """, 
        do: recite(number-1, take_down-1, [verse | verses])
    )

  defp bottles(1), do: "one green bottle"
  defp bottles(n) when is_map_key(@numbers, n), do: "#{@numbers[n]} green bottles"
end
