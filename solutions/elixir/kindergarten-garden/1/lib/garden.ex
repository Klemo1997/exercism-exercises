defmodule Garden do
  @doc """
    Accepts a string representing the arrangement of cups on a windowsill and a
    list with names of students in the class. The student names list does not
    have to be in alphabetical order.

    It decodes that string into the various gardens for each student and returns
    that information in a map.
  """
  @students [:alice, :bob, :charlie, :david, :eve, :fred, :ginny, :harriet, :ileana, :joseph, :kincaid, :larry]

  @spec info(String.t(), list) :: map
  def info(info_string), do: info(info_string, @students)
  def info(info_string, student_names) do
    [first, second] = String.split(info_string, "\n")
    info = student_names |> Enum.map(&({&1, {}})) |> Map.new()
    parse_info({first, second}, Enum.sort(student_names), info)
  end

  defp parse_info({<<>>, <<>>}, _, info), do: info
  defp parse_info({<<a, b, first::binary>>, <<c, d, second::binary>>}, [name | names], info), 
    do: parse_info({first, second}, names, Map.put(info, name, {decode(a), decode(b), decode(c), decode(d)}))

  defp decode(?G), do: :grass
  defp decode(?C), do: :clover
  defp decode(?R), do: :radishes
  defp decode(?V), do: :violets
end
