defmodule RPNCalculatorInspection do
  def start_reliability_check(calculator, input) do
    %{input: input, pid: spawn_link(fn -> calculator.(input) end)}
  end

  def await_reliability_check_result(%{pid: pid, input: input}, results) do
    receive do
      {:EXIT, ^pid, :normal} -> Map.put(results, input, :ok)
      {:EXIT, ^pid, _} -> Map.put(results, input, :error)
    after
      100 -> Map.put(results, input, :timeout)
    end
  end

  def reliability_check(calculator, inputs) do
    initial_trap_exit = Process.flag(:trap_exit, true)
    tasks = for input <- inputs, do: start_reliability_check(calculator, input)
    results = await_reliability_check_results(tasks, %{})
    Process.flag(:trap_exit, initial_trap_exit)
    results
  end

  defp await_reliability_check_results([], results), do: results
  defp await_reliability_check_results([task | tasks], results) do
    await_reliability_check_results(tasks, await_reliability_check_result(task, results))
  end

  def correctness_check(calculator, inputs) do
    inputs
    |> Enum.map(fn input -> Task.async(fn -> calculator.(input) end) end)
    |> Enum.map(fn task -> Task.await(task, 100) end)
  end
end
