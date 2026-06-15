defmodule TwoFer do
  @doc """
  Two-fer or 2-fer is short for two for one. One for you and one for me.
  """
  @spec two_fer(String.t()) :: String.t()
  def two_fer(name \\ "you") do
    if not Kernel.is_bitstring(name) do
      raise(FunctionClauseError, "Oops!")
    end

    "One for #{name}, one for me."
  end
end
