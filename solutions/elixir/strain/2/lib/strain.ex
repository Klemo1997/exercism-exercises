defmodule Strain do
  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns true.
  """
  @spec keep(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def keep(list, fun), do: kept(list, fun)

  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns false.
  """
  @spec discard(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def discard(list, fun), do: kept(list, &(!fun.(&1)))

  defp kept(list, keep?, kept \\ [])
  defp kept([], _, kept), do: Enum.reverse(kept)
  defp kept([item | list], keep?, kept),
    do: keep?.(item)
      |> then(fn 
        true -> kept(list, keep?, [item | kept])
        _ -> kept(list, keep?, kept)
      end)
end
