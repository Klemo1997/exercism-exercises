defmodule Queens do
  @type t :: %Queens{black: {integer, integer}, white: {integer, integer}}
  defstruct [:white, :black]

  @doc """
  Creates a new set of Queens
  """
  @spec new(Keyword.t()) :: Queens.t()
  def new(opts \\ []) do
    with opts <- Keyword.validate!(opts, [:white, :black]),
         white <- Keyword.get(opts, :white),
         black <- Keyword.get(opts, :black),
         true <- valid_position?(white),
         true <- valid_position?(black),
         false <- white != nil and white == black do
           %__MODULE__{white: white, black: black}
    else
      _ -> raise ArgumentError
    end
  end

  defp valid_position?({x, y}) when x in 0..7 and y in 0..7, do: true
  defp valid_position?(nil), do: true
  defp valid_position?(_), do: false

  @doc """
  Gives a string representation of the board with
  white and black queen locations shown
  """
  @spec to_string(Queens.t()) :: String.t()
  def to_string(%__MODULE__{white: white, black: black}) do
    for(row <- 0..7,
      do: for(col <- 0..7, 
        do: {row, col}
          |> then(fn
            ^black -> "B"
            ^white -> "W"
            _ -> "_"
          end))
      |> Enum.join(" "))
    |> Enum.join("\n")
  end

  @doc """
  Checks if the queens can attack each other
  """
  @spec can_attack?(Queens.t()) :: boolean
  def can_attack?(%__MODULE__{black: {x, _}, white: {x, _}}), do: true
  def can_attack?(%__MODULE__{black: {_, y}, white: {_, y}}), do: true
  def can_attack?(%__MODULE__{black: {x_b, y_b}, white: {x_w, y_w}}),
    do: abs(x_b - x_w) == abs(y_b - y_w)
  def can_attack?(%__MODULE__{}), do: false
end
