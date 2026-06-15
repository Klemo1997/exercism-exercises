defmodule TopSecret do
  @function_operations [:def, :defp]

  def decode_secret_message(source_code) do
    to_ast(source_code)
    |> Macro.prewalk([], &decode_secret_message_part/2)
    |> then(fn {_, message_parts} -> message_parts end)
    |> Enum.reverse() 
    |> Enum.join()
  end

  def to_ast(source_code), do: Code.string_to_quoted!(source_code)

  def decode_secret_message_part(
    ast = {operation, _, [{:when, _, [{func_name, _, func_args} | _]} | _]}, 
    message_parts) when operation in @function_operations do
      {ast, [message_part(func_name, func_args) | message_parts]}
  end
  def decode_secret_message_part(
    ast = {operation, _, [{func_name, _, func_args} | _]}, 
    message_parts) when operation in @function_operations do 
      {ast, [message_part(func_name, func_args) | message_parts]}
  end
  def decode_secret_message_part(ast, acc), do: {ast, acc}

  defp message_part(_, nil), do: ""
  defp message_part(func_name, func_args), do: String.slice(to_string(func_name), 0, Enum.count(func_args))
end
