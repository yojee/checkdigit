defmodule Checkdigit.ISBN10 do
  def verify(code) do
    if String.length(code) != 10 do
      false
    else
      try do
        checkdigit =
          case String.last(code) do
            "X" -> 10
            _ -> String.to_integer(String.last(code))
          end

        case generate(String.slice(code, 0..-2)) do
          {:ok, generated} -> generated == checkdigit
          {:error, _} -> false
        end
      rescue
        _ in ArgumentError -> false
      end
    end
  end

  def generate(seed) do
    if String.length(seed) != 9 do
      {:error, "checkdigit: length of seed is not appropriate"}
    else
      try do
        {
          :ok,
          seed
          |> String.codepoints()
          |> Enum.map(&String.to_integer/1)
          |> Enum.with_index()
          |> Enum.reduce(0, fn {v, i}, acc -> acc + (10 - i) * v end)
          |> rem(11)
          |> Kernel.-(11)
          |> Kernel.*(-1)
        }
      rescue
        _ in ArgumentError -> {:error, "checkdigit: seed contains non-number character"}
      end
    end
  end
end
