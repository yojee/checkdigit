defmodule Checkdigit.Damm do
  @matrix {
    {0, 3, 1, 7, 5, 9, 8, 6, 4, 2},
    {7, 0, 9, 2, 1, 5, 4, 8, 6, 3},
    {4, 2, 0, 6, 8, 7, 1, 3, 5, 9},
    {1, 7, 5, 0, 9, 8, 3, 4, 2, 6},
    {6, 1, 2, 3, 0, 4, 5, 9, 7, 8},
    {3, 6, 7, 4, 2, 0, 9, 5, 8, 1},
    {5, 8, 6, 9, 7, 2, 0, 1, 3, 4},
    {8, 9, 4, 5, 3, 6, 2, 0, 1, 7},
    {9, 4, 3, 8, 6, 1, 7, 2, 0, 5},
    {2, 5, 8, 1, 4, 3, 6, 7, 9, 0}
  }

  def verify(code) do
    if String.length(code) < 2 do
      false
    else
      try do
        case generate(String.slice(code, 0..-2//1)) do
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
    try do
      {
        :ok,
        seed
        |> String.codepoints()
        |> Enum.map(&String.to_integer/1)
        |> Enum.reduce(0, fn num, interim -> @matrix |> elem(interim) |> elem(num) end)
      }
    rescue
      _ in ArgumentError -> {:error, "checkdigit: seed contains non-number character"}
    end
  end
end
