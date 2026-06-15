defmodule NameBadge do
  @docmodule """
  Module for printing name badges for factory employees.
  """

  @spec print(integer()|nil, string(), String.t()|nil) :: String.t()
  def print(id, name, department) do
    formatted_department = if department !== nil, do: String.upcase(department), else: "OWNER"
    if id === nil do
      "#{name} - #{formatted_department}"
    else
      "[#{id}] - #{name} - #{formatted_department}"  
    end
  end
end
