defmodule LogParser do
  @valid_line_matcher ~r/^\[(DEBUG|INFO|WARNING|ERROR)\]/
  @end_of_line_matcher ~r/\<[~*=-]*>/
  @artifact_matcher ~r/end-of-line\d+/i
  @username_matcher ~r/User\s+(?<username>\S+)/

  def valid_line?(line), do: line |> String.match?(@valid_line_matcher)

  def split_line(line), do: line |> String.split(@end_of_line_matcher)

  def remove_artifacts(line), do: line |> String.replace(@artifact_matcher, "")

  def tag_with_user_name(line),
    do: Regex.named_captures(@username_matcher, line)
      |> then(fn
          nil -> line
          %{"username" => nil} -> line
          %{"username" => username} -> "[USER] #{username} " <> line
      end)
end
