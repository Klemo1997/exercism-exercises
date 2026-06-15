defmodule Isogram do
  import Bitwise
  
  @doc """
  Determines if a word or sentence is an isogram
  """
  @spec isogram?(String.t()) :: boolean
  def isogram?(sentence, mem \\ 0)
  def isogram?(<<l, sentence::binary>>, mem) when l in [?-, ?\s], do: isogram?(sentence, mem)
  def isogram?(<<l, sentence::binary>>, mem) when Bitwise.band(1 <<< rem(l, 32), mem) !== 0, do: false
  def isogram?(<<l, sentence::binary>>, mem), do: isogram?(sentence, Bitwise.bor(mem, 1 <<< rem(l, 32)))
  def isogram?(<<>>, mem), do: true
end
