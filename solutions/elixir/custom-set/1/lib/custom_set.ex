defmodule CustomSet do
  @opaque t :: %__MODULE__{map: map}

  defstruct map: %{}

  @spec new(Enum.t()) :: t
  def new(enumerable), 
    do: Enum.reduce(enumerable, %__MODULE__{}, &add(&2, &1))

  @spec empty?(t) :: boolean
  def empty?(%__MODULE__{map: map}), do: map == %{}

  @spec contains?(t, any) :: boolean
  def contains?(%__MODULE__{map: map}, element) when is_map_key(map, element), do: true
  def contains?(%__MODULE__{}, _), do: false

  @spec subset?(t, t) :: boolean
  def subset?(%__MODULE__{map: subset}, %__MODULE__{} = superset),
    do: Enum.all?(subset, fn {_, val} -> CustomSet.contains?(superset, val) end)

  @spec disjoint?(t, t) :: boolean
  def disjoint?(%__MODULE__{} = a, %__MODULE__{} = b) do
    intersection(a, b)
    |> empty?()
  end

  @spec equal?(t, t) :: boolean
  def equal?(a = %__MODULE__{}, b = %__MODULE__{}), do: a === b

  @spec add(t, any) :: t
  def add(%__MODULE__{map: map}, element) do
    %__MODULE__{map: Map.put(map, element, element)}
  end

  @spec intersection(t, t) :: t
  def intersection(%__MODULE__{map: a}, %__MODULE__{map: b}) do
    Map.intersect(a, b)
    |> Enum.map(&elem(&1, 0))
    |> new()
  end

  @spec difference(t, t) :: t
  def difference(%__MODULE__{map: a}, %__MODULE__{map: b}) do
    Map.keys(a) -- Map.keys(b)
    |> new()
  end

  @spec union(t, t) :: t
  def union(%__MODULE__{map: a}, %__MODULE__{map: b}) do
    Map.keys(a) ++ Map.keys(b)
    |> new()
  end
end
