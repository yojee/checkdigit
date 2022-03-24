defmodule CheckdigitJAN13Test do
  use ExUnit.Case
  doctest Checkdigit.JAN8
  doctest Checkdigit.JAN13
  doctest Checkdigit.EAN8
  doctest Checkdigit.EAN13
  doctest Checkdigit.ITF
  doctest Checkdigit.UPC
  alias Checkdigit.JAN8
  alias Checkdigit.JAN13
  alias Checkdigit.EAN8
  alias Checkdigit.EAN13
  alias Checkdigit.ITF
  alias Checkdigit.UPC

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

  test "EAN13.generate with regular patterns" do
    assert EAN13.generate("590123412345") == {:ok, 7}
  end

  test "EAN13.verify with regular patterns" do
    assert EAN13.verify("5901234123457") == true
  end

  test "JAN8.generate with regular patterns" do
    assert JAN8.generate("4996871") == {:ok, 2}
  end

  test "JAN8.verify with regular patterns" do
    assert JAN8.verify("49968712") == true
  end

  test "ITF.generate with regular patterns" do
    assert ITF.generate("1456995111617") == {:ok, 6}
  end

  test "ITF.verify with regular patterns" do
    assert ITF.verify("14569951116176") == true
  end

  test "UPC.generate with regular patterns" do
    assert UPC.generate("01234567890") == {:ok, 5}
  end

  test "UPC.verify with regular patterns" do
    assert UPC.verify("012345678905") == true
  end
end
