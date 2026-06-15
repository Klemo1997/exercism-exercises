defmodule PaintByNumber do
  @spec palette_bit_size(pos_integer()) :: pos_integer()
  def palette_bit_size(color_count), 
    do: Enum.find(0..color_count, &(Integer.pow(2, &1) >= color_count))

  @spec empty_picture() :: <<>>
  def empty_picture(), do: <<>>

  @spec test_picture() :: <<_::2>>
  def test_picture(), do: <<0::2, 1::2, 2::2, 3::2>>

  @spec prepend_pixel(bitstring(), pos_integer(), pos_integer()) :: bitstring()
  def prepend_pixel(picture, color_count, pixel_color_index) do
    bits = palette_bit_size(color_count)
    << pixel_color_index::size(bits), picture::bitstring >>
  end

  @spec get_first_pixel(bitstring(), pos_integer()) :: pos_integer() | nil
  def get_first_pixel(<< >>, _), do: nil

  def get_first_pixel(picture, color_count) do
    bits = palette_bit_size(color_count)
    << value::size(bits), _::bitstring >> = picture
    value
  end

  @spec drop_first_pixel(bitstring(), pos_integer()) :: bitstring()
  def drop_first_pixel(<< >>, _), do: empty_picture()

  def drop_first_pixel(picture, color_count) do
    bits = palette_bit_size(color_count)
    << _::size(bits), tail::bitstring >> = picture
    tail
  end

  @spec concat_pictures(bitstring(), bitstring()) :: bitstring()
  def concat_pictures(picture1, picture2), do: << picture1::bitstring, picture2::bitstring >>
end
