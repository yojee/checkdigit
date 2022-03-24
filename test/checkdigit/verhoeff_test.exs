defmodule CheckdigitVerhoeffTest do
  use ExUnit.Case
  doctest Checkdigit.Verhoeff

  import Checkdigit.Verhoeff, only: [generate: 1, verify: 1]

  test "generate: regular" do
    assert generate("236") == {:ok, 3}
    assert generate("097365") == {:ok, 2}
    assert generate("93847221003") == {:ok, 6}
    assert generate("2") == {:ok, 7}
  end

  test "generate: irregular" do
    assert generate("") == {:error, "checkdigit: seed is empty"}
    assert generate("a") == {:error, "checkdigit: seed contains non-number character"}
  end

  test "verify: regular" do
    assert verify("938472210036") == true
    assert verify("0973652") == true
    assert verify("27") == true
  end

  test "verify: irregular" do
    assert verify("2361") == false
    assert verify("") == false
    assert verify("a") == false
  end
end
