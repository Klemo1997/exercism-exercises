defmodule Change do
  @doc """
    Determine the least number of coins to be given to the user such
    that the sum of the coins' value would equal the correct amount of change.
    It returns {:error, "cannot change"} if it is not possible to compute the
    right amount of coins. Otherwise returns the tuple {:ok, list_of_coins}

    ## Examples

      iex> Change.generate([5, 10, 15], 3)
      {:error, "cannot change"}

      iex> Change.generate([1, 5, 10], 18)
      {:ok, [1, 1, 1, 5, 10]}

  """

  @spec generate(list, integer) :: {:ok, list} | {:error, String.t()}
  def generate(coins, target),
    do: {Enum.reverse(coins), Enum.max(coins)}
      |> tap(fn {coins, _} -> Enum.each(coins, &Process.put(&1, [&1]))  end)
      |> then(fn {coins, max_coin} -> change(coins, target, max_coin) end)
      |> then(fn
        nil -> {:error, "cannot change"}
        change -> {:ok, Enum.reverse(change)}
      end)

  defp change(_, 0, _), do: []
  defp change(coins, target, max_coin),
    do: memoized(target, fn -> 
          for coin <- coins, coin <= max_coin, coin <= target, reduce: nil do
              nil -> 
                maybe_prepend(coin, change(coins, target - coin, coin))
              prev_change ->
                change = maybe_prepend(coin, change(coins, target - coin, coin))
                if change != nil and length(change) < length(prev_change), do: change, else: prev_change
            end
        end)

  defp memoized(target, fun),
    do: Process.get(target)
      |> then(fn 
        nil -> fun.() |> tap(&Process.put(target, &1 || :none))
        :none -> nil
        memoized -> memoized
      end)

  defp maybe_prepend(_, nil), do: nil
  defp maybe_prepend(item, list), do: [item | list]
end
