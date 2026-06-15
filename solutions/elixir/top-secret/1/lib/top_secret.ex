defmodule TopSecret do
  def to_ast(string) do
    Code.string_to_quoted!(string)
  end

  defp extract_function_name_and_arity([{:when, _, _}, _] = args) do
    [{_, _, when_params}, _] = args
    [{name, _, params}, _] = when_params
    {to_string(name), Enum.count(params)}
  end
  defp extract_function_name_and_arity([{name, _, nil}, _]), do: {to_string(name), 0}
  defp extract_function_name_and_arity([{name, _, params}, _] ), do: {to_string(name), Enum.count(params)}

  defp extract_code_from_ast({atom, _, _} = ast) do
    {_, _, arguments} = ast
    {name, arity} = extract_function_name_and_arity(arguments)
    String.slice(name, 0, arity)
  end

  def decode_secret_message_part({:def, _, _} = ast, acc), do: {ast, [extract_code_from_ast(ast) | acc]}
  def decode_secret_message_part({:defp, _, _} = ast, acc), do: {ast, [extract_code_from_ast(ast) | acc]}
  def decode_secret_message_part(ast, acc), do: {ast, acc}

  def decode_secret_message(string) do
    ast = to_ast(string)
    {_, acc} = Macro.prewalk(ast, [], &decode_secret_message_part/2)
    acc
    |> Enum.reverse() 
    |> Enum.join()
  end
end
