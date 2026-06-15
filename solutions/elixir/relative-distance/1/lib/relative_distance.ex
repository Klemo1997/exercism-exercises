defmodule RelativeDistance do
  @doc """
  Find the degree of separation of two members given a given family tree.
  """
  @spec degree_of_separation(
          family_tree :: %{String.t() => [String.t()]},
          person_a :: String.t(),
          person_b :: String.t()
        ) :: nil | pos_integer()
  def degree_of_separation(family_tree, person_a, person_b) do
    family_tree
    |> graph()
    |> degree(person_a, person_b)
  end

  defp graph(family_tree) do
    Enum.reduce(family_tree, :digraph.new(), fn {parent, siblings}, graph -> 
      connect_all(graph, [parent | siblings])
    end)
  end

  defp connect_all(graph, people) do
    tap(graph, &for(person_a <- people, person_b <- people, person_a < person_b, do: connect(&1, person_a, person_b)))
  end

  defp connect(graph, person_a, person_b) do
    :digraph.add_vertex(graph, person_a)
    :digraph.add_vertex(graph, person_b)
    :digraph.add_edge(graph, person_a, person_b)
    :digraph.add_edge(graph, person_b, person_a)
  end

  defp degree(graph, person_a, person_b),
    do: :digraph.get_short_path(graph, person_a, person_b)
      |> then(fn
        false -> nil
        path -> max(length(path) - 1, 1)
      end)
end
