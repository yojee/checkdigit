defmodule Checkdigit.Luhn do
  @moduledoc """
  Implementation of the Luhn algorithm
  """

  @doc """
  Checks if the given code is valid

  ## Example
      case Checkdigit.Luhn.verify("411111111111111") do
        false -> IO.puts("invalid code")
        true -> IO.puts("invalid code")
      end

  """
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

  @doc """
  Generate a check digit from the given seed

  ## Example
      case Checkdigit.Luhn.generate("424242424242424") do
        {:ok, checkdigit} -> IO.puts(check)
        {:error, reason} -> IO.puts(reason)
      end

  """
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
