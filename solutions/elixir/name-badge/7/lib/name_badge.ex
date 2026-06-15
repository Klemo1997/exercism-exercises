defmodule NameBadge do
  @moduledoc """
  This is the Hello module.
  """

  @owner_department "owner"

  @spec print(integer()|nil, String.t(), String.t()|nil) :: String.t()
  def print(id, name, department) do
    formatted_department = (if department !== nil, do: department, else: @owner_department)
      |> String.upcase
    id_prefix = if id !== nil, do: "[#{id}] - ", else: ""

    "#{id_prefix}#{name} - #{formatted_department}"
  end
end
