defmodule OcrNumbers do
  @bin_fonts_and_numbers [
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
  def convert(input) when rem(length(input), 4) == 0, 
    do: Enum.chunk_every(input, 4)
      |> Enum.reduce_while([], fn maybe_number, numbers ->
        case convert(maybe_number, "") do
          {:ok, number} -> {:cont, [number | numbers]}
          {:error, _} = error -> {:halt, error}
        end
      end)
      |> then(fn
        {:error, _} = error -> error
        numbers -> numbers |> Enum.reverse() |> Enum.join(",") |> then(&{:ok, &1})
      end)
  def convert(_), do: {:error, "invalid line count"}

  def convert([
    <<row1::binary-size(3), rest1::binary>>,
    <<row2::binary-size(3), rest2::binary>>,
    <<row3::binary-size(3), rest3::binary>>,
    <<row4::binary-size(3), rest4::binary>>,
  ], result) do
    number([row1, row2, row3, row4])
    |> then(fn
      {:ok, number} -> number
      :error -> "?"
    end)
    |> then(&convert([rest1, rest2, rest3, rest4], result <> &1))
  end
  def convert(["", "", "", ""], result), do: {:ok, result}
  def convert(_, _), do: {:error, "invalid column count"}

  Enum.each(@bin_fonts_and_numbers, fn {font, number} -> 
    defp number(unquote(font)), do: {:ok, unquote(number)}
  end)
  defp number(_), do: :error
end
