defmodule CheckdigitDamm do
  use ExUnit.Case
  doctest Checkdigit.Damm

  import Checkdigit.Damm, only: [generate: 1, verify: 1]

  test "generate: regular" do
    assert generate("22456433232") == {:ok, 3}
    assert generate("54352543234") == {:ok, 6}
    assert generate("10493839530") == {:ok, 5}
    assert generate("08989435403") == {:ok, 5}
    assert generate("54994384990") == {:ok, 4}
    assert generate("3") == {:ok, 7}
  end

  test "generate: irregular" do
    assert generate("") == {:error, "checkdigit: seed is empty"}
    assert generate("a") == {:error, "checkdigit: seed contains non-number character"}
  end

  test "verify: regular" do
    assert verify("224564332323") == true
    assert verify("543525432346") == true
    assert verify("37") == true
  end


  test "verify: irregular" do
    assert verify("835323233227") == false
    assert verify("1") == false
    assert verify("") == false
    assert verify("a") == false
  end
end
