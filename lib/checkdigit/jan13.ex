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
