defmodule Checkdigit.Verhoeff do
  @multiplication {
    {0, 1, 2, 3, 4, 5, 6, 7, 8, 9},
    {1, 2, 3, 4, 0, 6, 7, 8, 9, 5},
    {2, 3, 4, 0, 1, 7, 8, 9, 5, 6},
    {3, 4, 0, 1, 2, 8, 9, 5, 6, 7},
    {4, 0, 1, 2, 3, 9, 5, 6, 7, 8},
    {5, 9, 8, 7, 6, 0, 4, 3, 2, 1},
    {6, 5, 9, 8, 7, 1, 0, 4, 3, 2},
    {7, 6, 5, 9, 8, 2, 1, 0, 4, 3},
    {8, 7, 6, 5, 9, 3, 2, 1, 0, 4},
    {9, 8, 7, 6, 5, 4, 3, 2, 1, 0}
  }
  @permutation {
    {0, 1, 2, 3, 4, 5, 6, 7, 8, 9},
    {1, 5, 7, 6, 2, 8, 3, 0, 9, 4},
    {5, 8, 0, 3, 7, 9, 6, 1, 4, 2},
    {8, 9, 1, 6, 0, 4, 3, 5, 2, 7},
    {9, 4, 5, 3, 1, 2, 6, 8, 7, 0},
    {4, 2, 8, 6, 5, 7, 3, 9, 0, 1},
    {2, 7, 9, 3, 8, 0, 6, 4, 1, 5},
    {7, 0, 4, 6, 9, 1, 3, 2, 5, 8}
  }
  @inverse {0, 4, 3, 2, 1, 5, 6, 7, 8, 9}

  def verify(code) do
    if String.length(code) < 2 do
      false
    else
      try do
        case generate(String.slice(code, 0..-2)) do
          {:ok, generated} -> generated == String.last(code) |> String.to_integer()
          {:error, _} -> false
        end
      rescue
        _ in ArgumentError -> false
      end
    end
  end

  def generate("") do
    {:error, "checkdigit: seed is empty"}
  end

  def generate(seed) do
    l = String.length(seed)

    try do
      num_lst =
        seed
        |> String.codepoints()
        |> Enum.map(&String.to_integer/1)

      interim =
        Range.new(0, l - 1)
        |> Enum.reduce(0, fn
          i, accum ->
            @multiplication
            |> elem(accum)
            |> elem(@permutation |> elem(rem(i + 1, 8)) |> elem(Enum.fetch!(num_lst, l - i - 1)))
        end)

      {:ok, elem(@inverse, interim)}
    rescue
      _ in ArgumentError -> {:error, "checkdigit: seed contains non-number character"}
    end
  end
end
