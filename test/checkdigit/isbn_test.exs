defmodule CheckdigitISBNTest do
  use ExUnit.Case
  doctest Checkdigit.ISBN10
  doctest Checkdigit.ISBN13

  alias Checkdigit.ISBN10
  alias Checkdigit.ISBN13

  test "ISBN10.generate: regular" do
    assert ISBN10.generate("002651562") == {:ok, 8}
    assert ISBN10.generate("007231592") == {:ok, 10}
    assert ISBN10.generate("155860832") == {:ok, 10}
  end

  test "ISBN10.generate: irregular" do
    assert ISBN10.generate("9780002715096") == {:error, "checkdigit: length of seed is not appropriate"}
    assert ISBN10.generate("15586") == {:error, "checkdigit: length of seed is not appropriate"}
    assert ISBN10.generate("15586083X") == {:error, "checkdigit: seed contains non-number character"}
    assert ISBN10.generate("aaaaaaaaa") == {:error, "checkdigit: seed contains non-number character"}
  end

  test "ISBN10.verify: regular" do
    assert ISBN10.verify("0026515628") == true
    assert ISBN10.verify("007231592X") == true
    assert ISBN10.verify("155860832X") == true
  end

  test "ISBN10.verify: irregular" do
    assert ISBN10.verify("155860831X") == false
    assert ISBN10.verify("9780002715096") == false
    assert ISBN10.verify("155860831") == false
    assert ISBN10.verify("") == false
    assert ISBN10.verify("aaaaaaaaaa") == false
  end

  test "ISBN13.generate: regular" do
    assert ISBN13.generate("978000271217") == {:ok, 0}
    assert ISBN13.generate("978000271330") == {:ok, 6}
    assert ISBN13.generate("978000271363") == {:ok, 4}
    assert ISBN13.generate("978000271236") == {:ok, 1}
  end

  test "ISBN13.generate: irregular" do
    assert ISBN13.generate("") == {:error, "checkdigit: length of seed is not appropriate"}
    assert ISBN13.generate("0026515628") == {:error, "checkdigit: length of seed is not appropriate"}
    assert ISBN13.generate("15586083211X") == {:error, "checkdigit: seed contains non-number character"}
    assert ISBN13.generate("aaaaaaaaaaaa") == {:error, "checkdigit: seed contains non-number character"}
  end

  test "ISBN13.verify: regular" do
    assert ISBN13.verify("9780002712095") == true
    assert ISBN13.verify("9780002715096") == true
    assert ISBN13.verify("9780002713306") == true
  end

  test "ISBN13.verify: irregular" do
    assert ISBN13.verify("155860831X") == false
    assert ISBN13.verify("9780002712520") == false
    assert ISBN13.verify("9780002712709") == false
    assert ISBN13.verify("") == false
    assert ISBN13.verify("aaaaaaaaaaaaa") == false
  end
end
