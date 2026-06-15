defmodule FileSniffer do
  @mimetype_exe "application/octet-stream"
  @mimetype_bmp "image/bmp"
  @mimetype_png "image/png"
  @mimetype_jpg "image/jpg"
  @mimetype_gif "image/gif"

  @spec type_from_extension(String.t()) :: String.t() | nil
  def type_from_extension("exe"), do: @mimetype_exe
  def type_from_extension("bmp"), do: @mimetype_bmp
  def type_from_extension("png"), do: @mimetype_png
  def type_from_extension("jpg"), do: @mimetype_jpg
  def type_from_extension("gif"), do: @mimetype_gif
  def type_from_extension(_), do: nil

  @spec type_from_binary(binary()) :: String.t() | nil
  def type_from_binary(<<0x7F, 0x45, 0x4C, 0x46, _::binary>>), do: @mimetype_exe
  def type_from_binary(<<0x42, 0x4D, _::binary>>), do: @mimetype_bmp
  def type_from_binary(<<0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, _::binary>>), do: @mimetype_png
  def type_from_binary(<<0xFF, 0xD8, 0xFF, _::binary>>), do: @mimetype_jpg
  def type_from_binary(<<0x47, 0x49, 0x46, _::binary>>), do: @mimetype_gif
  def type_from_binary(_), do: nil

  @spec verify(binary(), String.t()) :: {:ok, String.t()} | {:error, String.t()}
  def verify(file_binary, extension) do
    case {type_from_extension(extension), type_from_binary(file_binary)} do
      {consistent_type, consistent_type} -> {:ok, consistent_type}
      _ -> {:error, "Warning, file format and file extension do not match."}
    end
  end
end
