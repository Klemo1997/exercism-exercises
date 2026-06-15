defmodule LogParser do
  @valid_line_matcher ~r/^\[(DEBUG|INFO|WARNING|ERROR)\]/
  @end_of_line_matcher ~r/\<[~*=-]*>/
  @artifact_matcher ~r/end-of-line\d+/i
  @username_matcher ~r/User\s+(?<username>\S+)/

  def valid_line?(line), do: String.match?(line, @valid_line_matcher)

  def split_line(line), do: String.split(line, @end_of_line_matcher)

  def remove_artifacts(line), do: String.replace(line, @artifact_matcher, "")

  def tag_with_user_name(line),
    do: Regex.named_captures(@username_matcher, line)
      |> then(fn
          nil -> line
          %{"username" => nil} -> line
          %{"username" => username} -> "[USER] #{username} " <> line
      end)
end
