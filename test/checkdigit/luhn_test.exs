defmodule CheckdigitLuhnTest do
  use ExUnit.Case
  doctest Checkdigit.Luhn

  import Checkdigit.Luhn, only: [generate: 1, verify: 1]

  test "generate with regular patterns" do
    assert generate("424242424242424") == {:ok, 2}
    assert generate("510510510510510") == {:ok, 0}
    assert generate("37144963539843") == {:ok, 1}
    assert generate("3056930902590") == {:ok, 4}
    assert generate("353011133330000") == {:ok, 0}
    assert generate("3") == {:ok, 4}
  end

  test "generate with irregular patterns" do
    assert generate("") == {:error, "checkdigit: invalid argument"}
    assert generate("a") == {:error, "checkdigit: invalid argument"}
  end

  test "verify with regular patterns" do
    assert verify("4242424242424242") == true
    assert verify("5105105105105100") == true
    assert verify("34") == true
  end

  test "verify with irregular patterns" do
    assert verify("510510510510511") == false
    assert verify("") == false
    assert verify("a") == false
    assert verify("1a") == false
  end
end
