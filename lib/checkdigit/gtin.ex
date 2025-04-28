defmodule Checkdigit.Gtin do
  def verify(code, digit, pos_corr) do
    if String.length(code) != digit do
      false
    else
      try do
        case generate(String.slice(code, 0..-2//1), digit, pos_corr) do
          {:ok, generated} -> generated == String.last(code) |> String.to_integer()
          {:error, _} -> false
        end
      rescue
        _ in ArgumentError -> false
      end
    end
  end

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

defmodule Checkdigit.EAN8 do
  @digit 8
  @pos_corr 1

  def verify(code) do
    Checkdigit.Gtin.verify(code, @digit, @pos_corr)
  end

  def generate(seed) do
    Checkdigit.Gtin.generate(seed, @digit, @pos_corr)
  end
end

defmodule Checkdigit.EAN13 do
  @digit 13
  @pos_corr 1

  def verify(code) do
    Checkdigit.Gtin.verify(code, @digit, @pos_corr)
  end

  def generate(seed) do
    Checkdigit.Gtin.generate(seed, @digit, @pos_corr)
  end
end

defmodule Checkdigit.JAN8 do
  @digit 8
  @pos_corr 1

  def verify(code) do
    Checkdigit.Gtin.verify(code, @digit, @pos_corr)
  end

  def generate(seed) do
    Checkdigit.Gtin.generate(seed, @digit, @pos_corr)
  end
end

defmodule Checkdigit.JAN13 do
  @digit 13
  @pos_corr 1

  def verify(code) do
    Checkdigit.Gtin.verify(code, @digit, @pos_corr)
  end

  def generate(seed) do
    Checkdigit.Gtin.generate(seed, @digit, @pos_corr)
  end
end

defmodule Checkdigit.ITF do
  @digit 14
  @pos_corr 0

  def verify(code) do
    Checkdigit.Gtin.verify(code, @digit, @pos_corr)
  end

  def generate(seed) do
    Checkdigit.Gtin.generate(seed, @digit, @pos_corr)
  end
end

defmodule Checkdigit.UPC do
  @digit 12
  @pos_corr 1

  def verify(code) do
    Checkdigit.Gtin.verify(code, @digit, @pos_corr)
  end

  def generate(seed) do
    Checkdigit.Gtin.generate(seed, @digit, @pos_corr)
  end
end

defmodule Checkdigit.SSCC do
  @digit 18
  @pos_corr 0

  def verify(code) do
    Checkdigit.Gtin.verify(code, @digit, @pos_corr)
  end

  def generate(seed) do
    Checkdigit.Gtin.generate(seed, @digit, @pos_corr)
  end
end
