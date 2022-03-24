defmodule CheckdigitJAN13Test do
  use ExUnit.Case
  doctest Checkdigit.JAN13
  doctest Checkdigit.EAN8
  alias Checkdigit.JAN13
  alias Checkdigit.EAN8

  test "JAN13.generate with regular patterns" do
    assert JAN13.generate("456995111617") == {:ok, 9}
  end

  test "JAN13.generate with irregular patterns" do
    assert JAN13.generate("") == {:error, "checkdigit: length of seed is not appropriate"}

    assert JAN13.generate("aaaaaaaaaaaa") ==
             {:error, "checkdigit: seed contains a non-number character"}
  end

  test "JAN13.verify with regular patterns" do
    assert JAN13.verify("4569951116179") == true
  end

  test "EAN8.verify with irregular patterns" do
    assert EAN8.verify("") == false

    assert EAN8.verify("aaaaaaaaaaaa") == false
  end

  test "EAN8.generate with regular patterns" do
    assert EAN8.generate("9638112") == {:ok, 0}
  end

  test "EAN8.verify with regular patterns" do
    assert EAN8.verify("96385074") == true
  end

end
