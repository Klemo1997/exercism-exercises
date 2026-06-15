defmodule Plot do
  @type t() :: %Plot{plot_id: pos_integer(), registered_to: String.t()}

  @enforce_keys [:plot_id, :registered_to]
  defstruct [:plot_id, :registered_to]
end

defmodule CommunityGarden do
  @not_registered_plot_response {:not_found, "plot is unregistered"}
  @type plot_not_registered() :: {:not_found, String.t()}

  @spec start(keyword()) :: Agent.on_start()
  def start(_opts \\ []) do
    Agent.start(fn -> {[], 1} end)
  end

  @spec list_registrations(pid()) :: list(Plot.t())
  def list_registrations(pid) do
    Agent.get(pid, fn {registrations, _} -> registrations end)
  end

  @spec register(pid(), String.t()) :: Plot.t()
  def register(pid, register_to) do
    Agent.get_and_update(pid, fn {registrations, counter} -> 
      new_plot = %Plot{plot_id: counter, registered_to: register_to}
      {new_plot, {[new_plot | registrations], counter + 1}}
    end)
  end

  @spec release(pid(), pos_integer()) :: :ok
  def release(pid, plot_id) do
    Agent.update(pid, fn {registrations, counter} -> 
      {Enum.filter(registrations, &(&1.plot_id !== plot_id)), counter} 
    end)
  end

  @spec get_registration(pid(), pos_integer()) :: Plot.t() | plot_not_registered()
  def get_registration(pid, plot_id) do
    Agent.get(pid, fn {registrations, _} -> 
      Enum.find(registrations, @not_registered_plot_response, &(&1.plot_id === plot_id)) 
    end)
  end
end
