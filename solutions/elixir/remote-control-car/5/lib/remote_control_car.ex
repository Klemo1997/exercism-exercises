defmodule RemoteControlCar do
  @enforce_keys [:nickname]
  defstruct [:nickname, battery_percentage: 100, distance_driven_in_meters: 0]

  @type t() :: %RemoteControlCar{
    nickname: String.t(),
    battery_percentage: non_neg_integer(),
    distance_driven_in_meters: non_neg_integer(),
  }

  @drive_battery_drain 1
  @drive_distance_gain 20

  @spec new(String.t()) :: t()
  def new(nickname \\ "none"), do: %RemoteControlCar{nickname: nickname}

  @spec display_distance(t()) :: String.t()
  def display_distance(%RemoteControlCar{distance_driven_in_meters: distance}), do: "#{distance} meters"

  @spec display_battery(t()) :: String.t()
  def display_battery(%RemoteControlCar{battery_percentage: 0}), do: "Battery empty"  
  def display_battery(%RemoteControlCar{battery_percentage: percentage}), do: "Battery at #{percentage}%"

  @spec drive(t()) :: t()
  def drive(%RemoteControlCar{battery_percentage: 0} = rc_car), do: rc_car
  def drive(%RemoteControlCar{} = rc_car) do
    rc_car
    |> Map.update!(:battery_percentage, &(&1 - @drive_battery_drain))
    |> Map.update!(:distance_driven_in_meters, &(&1 + @drive_distance_gain))
  end
end
