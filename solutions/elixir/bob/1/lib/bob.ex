defmodule Bob do
  @spec hey(String.t()) :: String.t()
  def hey(input) do
    trimmed_input = String.trim(input)
    case {String.ends_with?(trimmed_input, "?"), input === String.upcase(input) and String.downcase(input) !== input, trimmed_input} do
      {true, true, _} -> "Calm down, I know what I'm doing!"
      {true, _, _} -> "Sure."
      {_, _, ""} -> "Fine. Be that way!"
      {_, true, _} -> "Whoa, chill out!"
      _ -> "Whatever."
    end
  end
end
