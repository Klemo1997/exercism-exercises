defmodule FlattenArray do
  @doc """
    Accept a list and return the list flattened without nil values.

    ## Examples

      iex> FlattenArray.flatten([1, [2], 3, nil])
      [1, 2, 3]

      iex> FlattenArray.flatten([nil, nil])
      []

  """

  @spec flatten(list) :: list
  def flatten(list), do: flattened(list, []) |> Enum.reverse()

  defp flattened([], acc), do: acc
  defp flattened([number | list], acc) when is_number(number), do: flattened(list, [number | acc])
  defp flattened([sublist | list], acc) when is_list(sublist), do: flattened(list, flattened(sublist, acc))
  defp flattened([_ | list], acc), do: flattened(list, acc)
end
