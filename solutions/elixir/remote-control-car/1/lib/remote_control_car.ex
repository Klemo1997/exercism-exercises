defmodule RemoteControlCar do
  @enforce_keys [:nickname]
  defstruct [:nickname, battery_percentage: 100, distance_driven_in_meters: 0]

  def new() do
    %RemoteControlCar{nickname: "none"}
  end

  def new(nickname) do
    %RemoteControlCar{nickname: nickname}
  end

  def display_distance(remote_car) do
    check_instance(remote_car)
    "#{remote_car.distance_driven_in_meters} meters"
  end

  def display_battery(remote_car) do
    check_instance(remote_car)
    battery_suffix = if remote_car.battery_percentage == 0,
      do: "empty",
      else: "at #{remote_car.battery_percentage}%"

    "Battery #{battery_suffix}"
  end

  def drive(remote_car) do
    check_instance(remote_car)

    if remote_car.battery_percentage == 0 do
      remote_car
    else
      remote_car
      |> Map.update!(:distance_driven_in_meters, &(&1 + 20))
      |> Map.update!(:battery_percentage, &(&1 - 1))
    end
  end

  defp check_instance(remote_car) do
    if not Kernel.is_struct(remote_car, RemoteControlCar) do
      raise(FunctionClauseError, "Oops!")
    end
  end
end
