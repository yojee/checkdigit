defmodule CheckdigitISBNTest do
  use ExUnit.Case
  doctest Checkdigit.ISBN10

  import Checkdigit.ISBN10, only: [generate: 1, verify: 1]

  test "generate: regular" do
    assert generate("002651562") == {:ok, 8}
    assert generate("007231592") == {:ok, 10}
    assert generate("155860832") == {:ok, 10}
  end

  test "generate: irregular" do
    assert generate("9780002715096") == {:error, "checkdigit: length of seed is not appropriate"}
    assert generate("15586") == {:error, "checkdigit: length of seed is not appropriate"}
    assert generate("15586083X") == {:error, "checkdigit: seed contains non-number character"}
    assert generate("aaaaaaaaa") == {:error, "checkdigit: seed contains non-number character"}
  end

  test "verify: regular" do
    assert verify("0026515628") == true
    assert verify("007231592X") == true
    assert verify("155860832X") == true
  end

  test "verify: irregular" do
    assert verify("155860831X") == false
    assert verify("9780002715096") == false
    assert verify("155860831") == false
    assert verify("") == false
    assert verify("aaaaaaaaaa") == false
  end
end
