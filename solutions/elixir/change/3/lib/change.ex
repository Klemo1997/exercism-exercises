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
  def generate(coins, target) do
    Task.async(fn -> change(coins, target) end)
    |> Task.await()
  end

  defp change(coins, target) do
    Process.put(0, [])
    Enum.each(coins, &Process.put(&1, [&1]))
    for t <- 1..target do
      for c <- coins do
        case {Process.get(t), Process.get(t-c)} do
          {nil, nil} -> nil
          {nil, val} -> Process.put(t, [c | val])
          {prev, curr} when length(prev) > length(curr) + 1 -> Process.put(t, [c | curr])
          {_, _} -> nil
        end
      end
    end
  
    case Process.get(target) do
      nil -> {:error, "cannot change"}
      val -> {:ok, val}
    end
  end
end
