defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(a, b) do
    cond do
      a === b -> :equal
      superlist?(a, b) -> :superlist
      superlist?(b, a) -> :sublist
      true -> :unequal
    end
  end

  def superlist?(a, b), do: superlist?(a, b, a, b)
  def superlist?([], [], _, _), do: true
  def superlist?(_, [], _, _), do: true
  def superlist?([], _, _, _), do: false
  def superlist?([x | a], [x | b], original_a, original_b), do: superlist?(a, b, original_a, original_b)
  def superlist?(_, _, [_ | original_a], original_b), do: superlist?(original_a, original_b, original_a, original_b)
end
