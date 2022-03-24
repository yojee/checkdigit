defmodule Checkdigit.Gtin do
  def generate(seed, digit, pos_corr) do
    if String.length(seed) != digit - 1 do
      {:error, "checkdigit: length of seed is not appropriate"}
    else
      try do
        {
          :ok,
          seed
          |> String.codepoints()
          |> Enum.map(&String.to_integer/1)
          |> Enum.with_index(pos_corr)
          |> Enum.reduce(0, fn
            {v, i}, acc when rem(i, 2) == 0 -> acc + v * 3
            {v, i}, acc when rem(i, 2) == 1 -> acc + v
          end)
          |> rem(10)
          |> Kernel.-(10)
          |> Kernel.*(-1)
          |> rem(10)
        }
      rescue
        _ in ArgumentError -> {:error, "checkdigit: seed contains a non-number character"}
      end
    end
  end
end
