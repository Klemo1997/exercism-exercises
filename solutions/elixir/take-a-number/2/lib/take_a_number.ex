defmodule TakeANumber do
  def start() do
    Kernel.spawn(&proc/1)
  end

  defp proc(state \\ 0) do
    receive do
      {:report_state, pid} ->
        send(pid, state)
        proc(state)
      {:take_a_number, pid} ->
        send(pid, state + 1)
        proc(state + 1)
      :stop -> nil
      _ -> proc(state)
    end
  end
end
