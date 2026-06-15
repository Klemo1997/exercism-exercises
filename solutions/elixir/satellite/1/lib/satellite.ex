defmodule Satellite do
  @typedoc """
  A tree, which can be empty, or made from a left branch, a node and a right branch
  """
  @type tree :: {} | {tree, any, tree}

  @doc """
  Build a tree from the elements given in a pre-order and in-order style
  """
  @spec build_tree(preorder :: [any], inorder :: [any]) :: {:ok, tree} | {:error, String.t()}
  def build_tree(preorder, inorder) do
    with :ok <- check_length(preorder, inorder),
         :ok <- check_same_elements(preorder, inorder),
         :ok <- check_unique_elements(preorder, inorder) do
         {:ok, build(preorder, inorder)}
    end
  end

  
  defp check_length(preorder, inorder) when length(preorder) != length(inorder),
    do: {:error, "traversals must have the same length"}
  defp check_length(_, _), do: :ok

  defp check_same_elements(preorder, inorder) do
    cond do
      Enum.sort(preorder) != Enum.sort(inorder) -> {:error, "traversals must have the same elements"}
      true -> :ok
    end
  end

  defp check_unique_elements(preorder, inorder) do
    cond do
      Enum.uniq(preorder) != preorder or Enum.uniq(inorder) != inorder ->
        {:error, "traversals must contain unique items"}
      true -> :ok
    end
  end

  defp build([], []), do: {}
  defp build([root | preorder], inorder) do
    root_inorder_index = Enum.find_index(inorder, &(&1 == root))
    {left_inorder, [^root | right_inorder]} = Enum.split(inorder, root_inorder_index)
    {left_preorder, right_preorder} = Enum.split(preorder, length(left_inorder))
    {build(left_preorder, left_inorder), root, build(right_preorder, right_inorder)}
  end
end
