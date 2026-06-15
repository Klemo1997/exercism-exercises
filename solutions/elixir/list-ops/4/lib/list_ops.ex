defmodule ListOps do
  # Please don't use any external modules (especially List or Enum) in your
  # implementation. The point of this exercise is to create these basic
  # functions yourself. You may use basic Kernel functions (like `Kernel.+/2`
  # for adding numbers), but please do not use Kernel functions for Lists like
  # `++`, `--`, `hd`, `tl`, `in`, and `length`.

  @spec count(list) :: non_neg_integer
  def count(list), do: foldl(list, 0, fn _, count -> count + 1 end)

  @spec reverse(list) :: list
  def reverse(list), do: foldl(list, [], &[&1 | &2])

  @spec map(list, (any -> any)) :: list
  def map(list, fun) when is_function(fun, 1), 
    do: foldr(list, [], &[fun.(&1) | &2])

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(list, fun) when is_function(fun, 1),
    do: foldr(list, [], &if(fun.(&1), do: [&1 | &2], else: &2))

  @type acc :: any
  @spec foldl(list, acc, (any, acc -> acc)) :: acc
  def foldl([item | list], acc, fun) when is_function(fun, 2), do: foldl(list, fun.(item, acc), fun)
  def foldl([], acc, _), do: acc

  @spec foldr(list, acc, (any, acc -> acc)) :: acc
  def foldr(list, acc, fun), do: foldl(reverse(list), acc, fun)

  @spec append(list, list) :: list
  def append(a, b), do: foldr(a, b, &[&1 | &2])

  @spec concat([[any]]) :: [any]
  def concat(list_of_lists), do: foldr(list_of_lists, [], &append/2)
end
