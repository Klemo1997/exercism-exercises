defmodule TopSecret do
  def to_ast(string), do: Code.string_to_quoted!(string)

  defp extract_function_name_and_arity([{:when, _, _} | _] = def_args) do
    [{_, _, when_args} | _] = def_args
    [{name, _, func_args} | _] = when_args
    {name, Enum.count(func_args)}
  end
  defp extract_function_name_and_arity([{name, _, nil} | _]), do: {name, 0}
  defp extract_function_name_and_arity([{name, _, func_args} | _]), do: {name, Enum.count(func_args)}

  defp extract_code_from_ast(ast) do
    {_, _, arguments} = ast
    {name, arity} = extract_function_name_and_arity(arguments)
    String.slice(to_string(name), 0, arity)
  end

  def decode_secret_message_part({operation, _, _} = ast, acc) when operation in [:def, :defp] do 
      {ast, [extract_code_from_ast(ast) | acc]}
  end
  def decode_secret_message_part(ast, acc), do: {ast, acc}

  def decode_secret_message(string) do
    ast = to_ast(string)
    {_, acc} = Macro.prewalk(ast, [], &decode_secret_message_part/2)
    acc
    |> Enum.reverse() 
    |> Enum.join()
  end
end
