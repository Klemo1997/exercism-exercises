defmodule ArmstrongNumber do
  @moduledoc """
  Provides a way to validate whether or not a number is an Armstrong number
  """

  @spec valid?(integer) :: boolean
  def valid?(number) do
    get_sum(number) === number
  end

  defp get_sum(number) do
    strnum = number 
    |> to_string 

    strlen = String.length(strnum)
    
    String.split(strnum, "", trim: true) 
    |> Enum.map(fn num -> String.to_integer(num) ** strlen end) |> Enum.reduce(fn acc, num -> acc + num end)
  end
end
