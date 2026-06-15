defmodule HighSchoolSweetheart do
  @moduledoc """
    This is the HighSchoolSweetheart module
  """

  @doc """
    Returns the first letter of given name
  """
  def first_letter(name) do
    name
    |> String.trim_leading()
    |> String.first()
  end

  def initial(name) do
    name
    |> first_letter()
    |> String.upcase()
    |> Kernel.<>(".")
  end

  def initials(full_name) do
    full_name
    |> String.split("\s")
    |> Enum.map_join(" ", &initial/1)
  end

  def pair(full_name1, full_name2) do
    """
         ******       ******
       **      **   **      **
     **         ** **         **
    **            *            **
    **                         **
    **     #{initials(full_name1)}  +  #{initials(full_name2)}     **
     **                       **
       **                   **
         **               **
           **           **
             **       **
               **   **
                 ***
                  *
    """
  end
end
