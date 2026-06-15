defmodule FileSniffer do
  def type_from_extension(extension) do
    case extension do
      "exe" -> "application/octet-stream"
      "bmp" -> "image/bmp"
      "png" -> "image/png"
      "jpg" -> "image/jpg"
      "gif" -> "image/gif"
      _ -> nil
    end
  end

  def type_from_binary(file_binary) do
    case file_binary do
      <<0x7F::size(8), 0x45::size(8), 0x4C::size(8), 0x46::size(8), _::binary>> -> "application/octet-stream"
      <<0x42::size(8), 0x4D::size(8), _::binary>> -> "image/bmp"
      <<0x89::size(8), 0x50::size(8), 0x4E::size(8), 0x47::size(8), 0x0D::size(8), 0x0A::size(8), 0x1A::size(8), 0x0A::size(8), _::binary>> -> "image/png"
      <<0xFF::size(8), 0xD8::size(8), 0xFF::size(8), _::binary>> -> "image/jpg"
      <<0x47::size(8), 0x49::size(8), 0x46::size(8), _::binary>> -> "image/gif"
      _ -> nil
    end
  end

  def verify(file_binary, extension) do
    extension_type = type_from_extension(extension)
    binary_type = type_from_binary(file_binary)

    if binary_type == extension_type do
      {:ok, extension_type}
    else
      {:error, "Warning, file format and file extension do not match."}
    end
  end
end
