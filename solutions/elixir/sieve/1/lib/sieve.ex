defmodule Sieve do
  @doc """
  Generates a list of primes up to a given limit.
  """
  @spec primes_to(non_neg_integer) :: [non_neg_integer]
  def primes_to(limit) do
    Task.async(fn -> generate_primes(limit) end)
    |> Task.await()
  end

  defp generate_primes(limit) when limit < 2, do: []
  defp generate_primes(limit) do
    Enum.each(2..limit, &Process.put(&1, true))
    
    for candidate <- 2..limit, candidate**2 < limit, Process.get(candidate) do
      mark_multiples_of(candidate, limit)
    end

    Enum.filter(2..limit, &Process.get(&1))
  end

  defp mark_multiples_of(prime, limit) do
    for multiple <- prime**2..limit//prime do
      Process.put(multiple, false)
    end
  end
end
