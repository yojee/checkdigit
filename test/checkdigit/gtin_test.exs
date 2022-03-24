defmodule CheckdigitJAN13Test do
  use ExUnit.Case
  doctest Checkdigit.JAN13
  alias Checkdigit.JAN13

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

  test "JAN13.verify with irregular patterns" do
    assert JAN13.verify("") == false

    assert JAN13.verify("aaaaaaaaaaaa") == false
  end
end
