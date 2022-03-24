defmodule CheckdigitJAN13Test do
  use ExUnit.Case
  doctest Checkdigit.JAN13

  import Checkdigit.JAN13, only: [generate: 1]

  test "generate with regular patterns" do
    assert generate("456995111617") == {:ok, 9}
  end

  test "generate with irregular patterns" do
    assert generate("") == {:error, "checkdigit: length of seed is not appropriate"}

    assert generate("aaaaaaaaaaaa") ==
             {:error, "checkdigit: seed contains a non-number character"}
  end
end
