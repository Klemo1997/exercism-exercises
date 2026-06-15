defmodule BinarySearchTree do
  @type bst_node :: %{data: any, left: bst_node | nil, right: bst_node | nil}

  @doc """
  Create a new Binary Search Tree with root's value as the given 'data'
  """
  @spec new(any) :: bst_node
  def new(data) do
    %{data: data, left: nil, right: nil}
  end

  @doc """
  Creates and inserts a node with its value as 'data' into the tree.
  """
  @spec insert(bst_node, any) :: bst_node
  def insert(nil, data), do: new(data)
  def insert(tree, data) when data <= tree.data, do: Map.update!(tree, :left, &insert(&1, data))
  def insert(tree, data), do: Map.update!(tree, :right, &insert(&1, data))

  @doc """
  Traverses the Binary Search Tree in order and returns a list of each node's data.
  """
  @spec in_order(bst_node) :: [any]
  def in_order(tree), do: in_order_traversal(tree, [])

  defp in_order_traversal(nil, traversed), do: traversed
  defp in_order_traversal(tree, traversed), do: in_order_traversal(tree.right, in_order_traversal(tree.left, traversed) ++ [tree.data])
end