defmodule PhoneNumber do
  @doc """
  Remove formatting from a phone number if the given number is valid. Return an error otherwise.
  """
  @spec clean(String.t()) :: {:ok, String.t()} | {:error, String.t()}
  def clean(raw) do
    case Regex.match?(~r/[^\d\.\+\-\(\)\s]/, raw) do
      true -> {:error, "must contain digits only"}
      _ -> raw
        |> String.replace(~r/\D/, "")
        |> then(fn digits -> validate(digits, String.length(digits)) end)
    end
  end

  defp validate(digits, len) when len > 11, do: {:error, "must not be greater than 11 digits"}
  defp validate(digits, len) when len < 10, do: {:error, "must not be fewer than 10 digits"}
  defp validate("1" <> digits, 11), do: validate(digits, 10)
  defp validate(digits, 11), do: {:error, "11 digits must start with 1"}
  defp validate(<<?0, rest::binary>>, 10), do: {:error, "area code cannot start with zero"}
  defp validate(<<?1, rest::binary>>, 10), do: {:error, "area code cannot start with one"}
  defp validate(<<_, _, _, ?0, rest::binary>>, 10), do: {:error, "exchange code cannot start with zero"}
  defp validate(<<_, _, _, ?1, rest::binary>>, 10), do: {:error, "exchange code cannot start with one"}
  defp validate(digits, 10), do: {:ok, digits}
end
