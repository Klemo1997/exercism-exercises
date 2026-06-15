defmodule CollatzConjecture do
  @spec is_valid(any()) :: boolean()
  defguardp is_valid(value) when is_integer(value) and value > 0

  @spec calc(input :: pos_integer()) :: non_neg_integer()
  def calc(input), do: compute(input, 0)

  @spec compute(pos_integer(), non_neg_integer()) :: non_neg_integer()
  defp compute(1, steps), do: steps
  defp compute(number, steps) when is_valid(number) and rem(number, 2) === 0, do: compute(div(number, 2), steps + 1)
  defp compute(number, steps) when is_valid(number), do: compute((number*3)+1, steps + 1)
end
