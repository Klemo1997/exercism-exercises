defmodule OcrNumbers do
  @bin_fonts_and_digits [
    {
      [
        " _ ",
        "| |",
        "|_|",
        "   "
      ],
      "0"
    },
    {
      [
        "   ",
        "  |",
        "  |",
        "   "
      ],
      "1"
    },
    {
      [
        " _ ",
        " _|",
        "|_ ",
        "   "
      ],
      "2"
    },
    {
      [
        " _ ",
        " _|",
        " _|",
        "   "
      ],
      "3"
    },
    {
      [
        "   ",
        "|_|",
        "  |",
        "   ",
      ],
      "4"
    },
    {
      [
        " _ ",
        "|_ ",
        " _|",
        "   "
      ],
      "5"
    },
    {
      [
        " _ ",
        "|_ ",
        "|_|",
        "   "
      ],
      "6"
    },
    {
      [
        " _ ",
        "  |",
        "  |",
        "   "
      ],
      "7"
    },
    {
      [
        " _ ",
        "|_|",
        "|_|",
        "   "
      ],
      "8"
    },
    {
      [
        " _ ",
        "|_|",
        " _|",
        "   "
      ],
      "9"
    },
  ]

  @doc """
  Given a 3 x 4 grid of pipes, underscores, and spaces, determine which number is represented, or
  whether it is garbled.
  """
  @spec convert([String.t()]) :: {:ok, String.t()} | {:error, String.t()}
  def convert(input) do
    with {:ok, lines} <- convert_lines(input) do
      {:ok, Enum.join(lines, ",")}
    end
  end

  defp convert_lines(lines, converted \\ [])
  defp convert_lines([l1, l2, l3, l4 | lines], converted) do
    with {:ok, number} <- number([l1, l2, l3, l4]) do
      convert_lines(lines, [number | converted])
    end
  end
  defp convert_lines([], converted), do: {:ok, Enum.reverse(converted)}
  defp convert_lines(_invalid_lines, _), do: {:error, "invalid line count"}

  defp number(line, number \\ "")
  defp number([
    <<r1::binary-size(3), rest1::binary>>,
    <<r2::binary-size(3), rest2::binary>>,
    <<r3::binary-size(3), rest3::binary>>,
    <<r4::binary-size(3), rest4::binary>>,
  ], number), do: number([rest1, rest2, rest3, rest4], number <> digit([r1, r2, r3, r4]))
  defp number(["", "", "", ""], number), do: {:ok, number}
  defp number(_invalid_columns, _), do: {:error, "invalid column count"}

  Enum.each(@bin_fonts_and_digits, fn {font, digit} -> 
    defp digit(unquote(font)), do: unquote(digit)
  end)
  defp digit(_), do: "?"
end
