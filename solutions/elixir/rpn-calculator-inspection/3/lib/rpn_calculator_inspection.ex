defmodule RPNCalculatorInspection do
  @timeout 100

  def start_reliability_check(calculator, input) do
    %{input: input, pid: spawn_link(fn -> calculator.(input) end)}
  end

  def await_reliability_check_result(%{pid: pid, input: input}, results) do
    receive do
      {:EXIT, ^pid, :normal} -> Map.put(results, input, :ok)
      {:EXIT, ^pid, _} -> Map.put(results, input, :error)
    after
      @timeout -> Map.put(results, input, :timeout)
    end
  end

  def reliability_check(calculator, inputs),
    do: with(
      initial_trap_exit <- Process.flag(:trap_exit, true),
      results <- for input <- inputs do start_reliability_check(calculator, input) end
        |> Enum.reduce(%{}, fn task, results -> await_reliability_check_result(task, results) end),
      _ <- Process.flag(:trap_exit, initial_trap_exit),
      do: results
    )

  def correctness_check(calculator, inputs) do
    for input <- inputs do Task.async(fn -> calculator.(input) end) end
    |> Task.await_many(@timeout)
  end
end
