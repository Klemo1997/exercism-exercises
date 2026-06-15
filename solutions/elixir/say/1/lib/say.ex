defmodule Say do
  @doc """
  Translate a positive integer into English.
  """
  @spec in_english(integer) :: {atom, String.t()}
  def in_english(0), do: {:ok, "zero"}
  def in_english(number) when is_integer(number) and number in 1..999_999_999_999,
    do: groups(number)
      |> Enum.join(" ")
      |> then(&({:ok, &1}))
  def in_english(_), do: {:error, "number is out of range"}
  
  def groups(number, groups \\ [])
  def groups(0, groups), do: groups
  def groups(number, groups) when number >= 1_000_000_000, 
    do: groups(rem(number, 1_000_000_000), [numeric_word(div(number, 1_000_000_000)) <> " billion" | groups])
  def groups(number, groups) when number >= 1_000_000,
    do: groups(rem(number, 1_000_000), [numeric_word(div(number, 1_000_000)) <> " million" | groups])
  def groups(number, groups) when number >= 1_000,
    do: groups(rem(number, 1_000), [numeric_word(div(number, 1_000)) <> " thousand" | groups])
  def groups(number, groups), do: [numeric_word(number) | groups] |> Enum.reverse()

  defp numeric_word(0), do: ""
  defp numeric_word(1), do: "one"
  defp numeric_word(2), do: "two"
  defp numeric_word(3), do: "three"
  defp numeric_word(4), do: "four"
  defp numeric_word(5), do: "five"
  defp numeric_word(6), do: "six"
  defp numeric_word(7), do: "seven"
  defp numeric_word(8), do: "eigth"
  defp numeric_word(9), do: "nine"
  defp numeric_word(10), do: "ten"
  defp numeric_word(11), do: "eleven"
  defp numeric_word(12), do: "twelve"
  defp numeric_word(13), do: "thirteen"
  defp numeric_word(14), do: "fourteen"
  defp numeric_word(15), do: "fifteen"
  defp numeric_word(16), do: "sixteen"
  defp numeric_word(17), do: "seventeen"
  defp numeric_word(18), do: "eighteen"
  defp numeric_word(19), do: "nineteen"
  defp numeric_word(number) when number >= 100,
    do: numeric_word(div(number, 100)) <> " hundred" <> maybe_prepend(" ", numeric_word(rem(number, 100)))
  defp numeric_word(number) when number >= 90, do: "ninety" <> maybe_prepend("-", numeric_word(rem(number, 90)))
  defp numeric_word(number) when number >= 80, do: "eighty" <> maybe_prepend("-", numeric_word(rem(number, 80)))
  defp numeric_word(number) when number >= 70, do: "seventy" <> maybe_prepend("-", numeric_word(rem(number, 70)))
  defp numeric_word(number) when number >= 60, do: "sixty" <> maybe_prepend("-", numeric_word(rem(number, 60)))
  defp numeric_word(number) when number >= 50, do: "fifty" <> maybe_prepend("-", numeric_word(rem(number, 50)))
  defp numeric_word(number) when number >= 40, do: "forty" <> maybe_prepend("-", numeric_word(rem(number, 40)))
  defp numeric_word(number) when number >= 30, do: "thirty" <> maybe_prepend("-", numeric_word(rem(number, 30)))
  defp numeric_word(number) when number >= 20, do: "twenty" <> maybe_prepend("-", numeric_word(rem(number, 20)))

  defp maybe_prepend(prefix, ""), do: ""
  defp maybe_prepend(prefix, word), do: prefix <> word
end
