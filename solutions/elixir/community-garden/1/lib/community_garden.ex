# Use the Plot struct as it is provided
defmodule Plot do
  @enforce_keys [:plot_id, :registered_to]
  defstruct [:plot_id, :registered_to]
end

defmodule CommunityGarden do
  def start() do
    Agent.start(fn -> {1, []} end)
  end

  def list_registrations(pid) do
    Agent.get(pid, fn {_, registrations} -> registrations end)
  end

  def register(pid, register_to) do
    id = get_last_id(pid)
    register_plot(pid, %Plot{plot_id: id, registered_to: register_to})
  end

  defp get_last_id(pid) do
    Agent.get(pid, fn {id_counter, _} -> id_counter end)
  end

  defp register_plot(pid, plot) do
    Agent.update(
      pid,
      fn {id_counter, registrations} -> {id_counter + 1, [plot | registrations]} end
    )
    plot
  end

  def release(pid, plot_id) do
    Agent.update(
      pid,
      fn {id_counter, registrations} ->
        {
          id_counter,
          Enum.filter(registrations, &(&1.plot_id != plot_id))
        }
      end
    )
  end

  def get_registration(pid, plot_id) do
    pid
    |> list_registrations
    |> Enum.find(
      {:not_found, "plot is unregistered"},
      &(&1.plot_id == plot_id)
    )
  end
end
