defmodule Strain do
  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns true.
  """
  @spec keep(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def keep(list, fun), do: kept(list, fun)

  defp kept(list, predicate, kept \\ [])
  defp kept([], _, kept), do: Enum.reverse(kept)
  defp kept([item | list], predicate, kept),
    do: predicate.(item)
      |> then(fn 
        true -> kept(list, predicate, [item | kept])
        _ -> kept(list, predicate, kept)
      end)

  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns false.
  """
  @spec discard(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def discard(list, fun), do: discarded(list, fun)

  defp discarded(list, predicate, discarded \\ [])
  defp discarded([], _, discarded), do: Enum.reverse(discarded)
  defp discarded([item | list], predicate, discarded),
    do: predicate.(item)
      |> then(fn 
        false -> discarded(list, predicate, [item | discarded])
        _ -> discarded(list, predicate, discarded)
      end)
end
