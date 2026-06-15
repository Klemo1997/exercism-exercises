defmodule ResistorColor do
  @black_color_code 0
  @brown_color_code 1
  @red_color_code 2
  @orange_color_code 3
  @yellow_color_code 4
  @green_color_code 5
  @blue_color_code 6
  @violet_color_code 7
  @grey_color_code 8
  @white_color_code 9

  @doc """
  Return the value of a color band
  """
  @spec code(atom) :: integer()
  def code(:black), do: @black_color_code
  def code(:brown), do: @brown_color_code
  def code(:red), do: @red_color_code
  def code(:orange), do: @orange_color_code
  def code(:yellow), do: @yellow_color_code
  def code(:green), do: @green_color_code
  def code(:blue), do: @blue_color_code
  def code(:violet), do: @violet_color_code
  def code(:grey), do: @grey_color_code
  def code(:white), do: @white_color_code
end
