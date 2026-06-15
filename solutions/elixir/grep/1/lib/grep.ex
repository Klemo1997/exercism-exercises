defmodule Grep do
  @spec grep(String.t(), [String.t()], [String.t()]) :: String.t()
  def grep(pattern, flags, files) do
    with options <- options(flags, files),
         matcher <- matcher(pattern, options) do
          files
          |> Enum.map(fn file -> grep(matcher, Map.put(options, :file_name, file)) end)
          |> Enum.join()
         end
  end

  def grep(matcher, %{file_name: file} = options) when is_function(matcher, 1),
    do: file
      |> File.stream!()
      |> Stream.with_index(1)
      |> Stream.filter(fn {line, _} -> matcher.(line) end)
      |> format(options)

  defp options(flags, files), do: %{
    multiple_files?: length(files) > 1,
    line_numbers?: "-n" in flags,
    output_filename?: "-l" in flags,
    inverse_match?: "-v" in flags,
    case_insensitive?: "-i" in flags,
    full_line_match?: "-x" in flags,
  }

  defp matcher(pattern, %{inverse_match?: true} = options),
    do: fn line -> not matcher(pattern, %{options | inverse_match?: false}).(line) end
  defp matcher(pattern, %{case_insensitive?: case_insensitive?, full_line_match?: full_line_match?}) do
    fn line ->
       cond do
        full_line_match? and case_insensitive? -> line =~ ~r/^#{pattern}\n$/i
        full_line_match? -> line =~ ~r/^#{pattern}\n$/
        case_insensitive? -> line =~ ~r/#{pattern}/i
        true -> line =~ pattern
      end
    end
  end

  defp format(matches, %{output_filename?: true, file_name: file_name}),
    do: (if not Enum.empty?(matches), do: file_name <> "\n", else: "")
  defp format(matches, %{} = options) do
    matches
     |> Stream.map(fn line_and_number -> format(:line_number, line_and_number, options) end)
     |> Stream.map(fn line_and_number -> format(:file_name, line_and_number, options) end)
     |> Stream.map(fn {line, _} -> line end)
     |> Enum.join()
  end

  defp format(:line_number, {line, line_number}, %{line_numbers?: true}), do: {"#{line_number}:#{line}", line_number}
  defp format(:file_name, {line, line_number}, %{multiple_files?: true, file_name: file_name}),
    do: {"#{file_name}:#{line}", line_number}
  defp format(_, line_and_number, _), do: line_and_number
end
