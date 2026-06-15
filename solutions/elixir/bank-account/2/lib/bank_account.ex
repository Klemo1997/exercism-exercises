defmodule BankAccount do
  @moduledoc """
  A bank account that supports access from multiple processes.
  """

  @typedoc """
  An account handle.
  """
  @opaque account :: pid

  @doc """
  Open the bank account, making it available for further operations.
  """
  @spec open() :: account
  def open() do
    {:ok, account} = Agent.start_link(fn -> 0 end)
    account
  end

  @doc """
  Close the bank account, making it unavailable for further operations.
  """
  @spec close(account) :: any
  def close(account) do
    Agent.stop(account)
  end

  @doc """
  Get the account's balance.
  """
  @spec balance(account) :: integer | {:error, :account_closed}
  def balance(account) do
    maybe_apply(account, fn -> Agent.get(account, & &1) end)
  end

  @doc """
  Add the given amount to the account's balance.
  """
  @spec deposit(account, integer) :: :ok | {:error, :account_closed | :amount_must_be_positive}
  def deposit(account, amount) do
    maybe_apply(account, fn -> 
      Agent.get_and_update(account, fn
        balance when amount > 0 -> balance + amount
          |> then(fn new_balance -> {:ok, new_balance} end)
        balance -> {{:error, :amount_must_be_positive}, balance}
      end)
    end)
  end

  @doc """
  Subtract the given amount from the account's balance.
  """
  @spec withdraw(account, integer) ::
          :ok | {:error, :account_closed | :amount_must_be_positive | :not_enough_balance}
  def withdraw(account, amount) do
    account
    |> maybe_apply(fn -> 
        Agent.get_and_update(account, fn 
          balance when amount <= 0 -> {{:error, :amount_must_be_positive}, balance}
          balance when balance >= amount -> {:ok, balance - amount}
          balance -> {{:error, :not_enough_balance}, balance}
        end)
      end)
  end

  defp maybe_apply(account, operation) do
    if Process.alive?(account) do
      operation.()
    else
      {:error, :account_closed}
    end
  end
end
