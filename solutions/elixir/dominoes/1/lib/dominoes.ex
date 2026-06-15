defmodule Dominoes do
  import Enum, only: [any?: 2]
  import List, only: [delete: 2]
  @type domino :: {1..6, 1..6}

  @doc """
  chain?/1 takes a list of domino stones and returns boolean indicating if it's
  possible to make a full chain
  """
  @spec chain?(dominoes :: [domino]) :: boolean
  def chain?([]), do: true
  def chain?([first | other]), do: completable_to_chain?(first, other)
  # the chain is representend like a single domino, by its start/left and end/right value
  defp completable_to_chain?({s, e}, []), do: s == e # completed chain is only valid, if start value equals end value
  defp completable_to_chain?({s, e}, dominoes), do:
    any?(dominoes, fn
      chainable = {^e, x} -> completable_to_chain?({s, x}, delete(dominoes, chainable))
      chainable_when_flipped = {x, ^e} -> completable_to_chain?({s, x}, delete(dominoes, chainable_when_flipped))
      _not_chainable -> false
    end) 
end
