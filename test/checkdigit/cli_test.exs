defmodule CheckdigitCLITest do
  use ExUnit.Case
  doctest Checkdigit.CLI

  import Checkdigit.CLI, only: [parse_args: 1]

  test ":help retuned by option parsing with -h and --help option" do
    assert parse_args(["-h", "something"]) == :help
    assert parse_args(["--help", "something"]) == :help
  end

  test "three calues returned if three given" do
    assert parse_args(["generate", "13", "verhoeff"]) == {:generate, "13", :verhoeff}
    assert parse_args(["verify", "13", "verhoeff"]) == {:verify, "13", :verhoeff}
  end

  test "provider is defaulted if two vales given" do
    assert parse_args(["generate", "13"]) == {:generate, "13", :luhn}
    assert parse_args(["verify", "13"]) == {:verify, "13", :luhn}
  end

  test ":help returned if provider is not supported" do
    assert(parse_args(["generate", "13", "not_supported"]) == :help)
    assert(parse_args(["verify", "13", "not_supported"]) == :help)
  end
end
