defmodule Checkdigit.Luhn do
  def generate("") do
    {:error, "checkdigit: invalid argument"}
  end

  def generate(seed) do
    try do
      {:ok,
       seed
       |> String.codepoints()
       |> Enum.map(&String.to_integer/1)
       |> Enum.with_index(rem(String.length(seed) + 1, 2))
       |> Enum.reduce(0, fn
         {v, i}, acc when rem(i, 2) == 0 and v * 2 >= 10 -> acc + v * 2 - 9
         {v, i}, acc when rem(i, 2) == 0 -> acc + v * 2
         {v, i}, acc when rem(i, 2) == 1 -> acc + v
       end)
       |> rem(10)
       |> Kernel.-(10)
       |> Kernel.*(-1)
       |> rem(10)}
    rescue
      _ in ArgumentError -> {:error, "checkdigit: invalid argument"}
    end
  end
end
