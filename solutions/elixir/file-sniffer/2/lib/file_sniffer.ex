defmodule FileSniffer do
  @extensions [
    %{media_type: "application/octet-stream", signature: <<0x7F, 0x45, 0x4C, 0x46>>, extension: "exe"},
    %{media_type: "image/bmp", signature: <<0x42, 0x4D>>, extension: "bmp"},
    %{media_type: "image/png", signature: <<0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A>>, extension: "png"},
    %{media_type: "image/jpg", signature: <<0xFF, 0xD8, 0xFF>>, extension: "jpg"},
    %{media_type: "image/gif", signature: <<0x47, 0x49, 0x46>>, extension: "gif"},
  ]

  def type_from_extension(extension) do
    match = Enum.find(@extensions, fn %{extension: item_extension} -> extension == item_extension end)

    Map.get(match || %{}, :media_type)
  end

  def type_from_binary(file_binary) do
    match = Enum.find(@extensions, fn %{signature: signature} -> String.starts_with?(file_binary, signature) end)

    Map.get(match || %{}, :media_type)
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
