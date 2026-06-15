defmodule Markdown do
  def parse(markdown),
    do: markdown
      |> String.split("\n")
      |> Enum.map(&html/1)
      |> group_tags()
      |> Enum.join()

  defp html("###### " <> content), do: tag("h6", content)
  defp html("##### " <> content), do: tag("h5", content)
  defp html("#### " <> content), do: tag("h4", content)
  defp html("### " <> content), do: tag("h3", content)
  defp html("## " <> content), do: tag("h2", content)
  defp html("# " <> content), do: tag("h1", content)
  defp html("* " <> content), do: tag("li", content)
  defp html(content), do: tag("p", content)

  defp group_tags(lines, groups \\ [])
  defp group_tags(["<li>" <> _ | _] = lines, groups) do
    lines
    |> unordered_list()
    |> then(fn {list, rest_of_lines} -> group_tags(rest_of_lines, list ++ groups) end)
  end
  defp group_tags([item | list_item], groups), do: group_tags(list_item, [item | groups])
  defp group_tags([], groups), do: Enum.reverse(groups)

  defp unordered_list(lines, unordered_list \\ ["<ul>"])
  defp unordered_list(["<li>" <> _ = item | lines], unordered_list), do: unordered_list(lines, [item | unordered_list])
  defp unordered_list([], unordered_list), do: {["</ul>" | unordered_list], []}
  defp unordered_list(lines, unordered_list), do: {["</ul>" | unordered_list], lines}

  defp tag(tag, content), do: "<#{tag}>#{html_content(content)}</#{tag}>"

  defp html_content(content) do
    content
    |> String.replace(~r/__((?:(?!__).)+)__/, "<strong>\\1</strong>")
    |> String.replace(~r/_((?:(?!_).)+)_/, "<em>\\1</em>")
  end
end
