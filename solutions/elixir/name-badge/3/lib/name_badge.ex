defmodule NameBadge do
  def print(id, name, department) do
    id_prefix = if id == nil,
                  do: "",
                  else: "[#{id}] - "

    department_suffix = if department == nil,
                          do: "Owner",
                          else: department

    "#{id_prefix}#{name} - #{String.upcase(department_suffix)}"
  end
end
