defmodule Checkdigit.JAN13 do
  @digit 13
  @pos_corr 1

  def generate(seed) do
    Checkdigit.Gtin.generate(seed, @digit, @pos_corr)
  end
end
