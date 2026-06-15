defmodule ListOps do
  # Please don't use any external modules (especially List or Enum) in your
  # implementation. The point of this exercise is to create these basic
  # functions yourself. You may use basic Kernel functions (like `Kernel.+/2`
  # for adding numbers), but please do not use Kernel functions for Lists like
  # `++`, `--`, `hd`, `tl`, `in`, and `length`.

  @spec count(list) :: non_neg_integer
  def count(list), do: count(list, 0)
  defp count([_ | list], count), do: count(list, count + 1)
  defp count([], count), do: count

  @spec reverse(list) :: list
  def reverse(list), do: reverse(list, [])
  defp reverse([item | list], reversed), do: reverse(list, [item | reversed])
  defp reverse([], reversed), do: reversed

  @spec map(list, (any -> any)) :: list
  def map(list, fun) when is_function(fun, 1), do: map(list, fun, [])
  defp map([item | list], fun, mapped), do: map(list, fun, [fun.(item) | mapped])
  defp map([], _, mapped), do: reverse(mapped)

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(list, fun) when is_function(fun, 1), do: filter(list, fun, [])
  defp filter([item | list], fun, filtered) do
    if fun.(item), do: filter(list, fun, [item | filtered]), else: filter(list, fun, filtered)
  end
  defp filter([], _, filtered), do: reverse(filtered)

  @type acc :: any
  @spec foldl(list, acc, (any, acc -> acc)) :: acc
  def foldl([item | list], acc, fun), do: foldl(list, fun.(item, acc), fun)
  def foldl([], acc, _), do: acc

  @spec foldr(list, acc, (any, acc -> acc)) :: acc
  def foldr(list, acc, fun), do: reverse(list) |> foldl(acc, fun)

  @spec append(list, list) :: list
  def append(a, b), do: append(a, b, [])
  defp append([item | a], b, appended), do: append(a, b, [item | appended])
  defp append([], [item | b], appended), do: append([], b, [item | appended])
  defp append([], [], appended), do: reverse(appended)

  @spec concat([[any]]) :: [any]
  def concat(list_of_lists), do: foldr(list_of_lists, [], &append/2)
end
