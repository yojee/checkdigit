defmodule CheckdigitCLITest do
  use ExUnit.Case
  import ExUnit.CaptureIO
  import Checkdigit.CLI, only: [parse_args: 1, run: 1]
  doctest Checkdigit.CLI

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

  test "run(), verify, 2 args, luhn, regular" do
    result = capture_io(fn -> run(["verify", "4242424242424242"]) end)

    assert result == "true\n"
  end

  test "run(), verify, 2 args, luhn, irregular" do
    result = capture_io(fn -> run(["verify", "510510510510511"]) end)

    assert result == "false\n"
  end

  test "run(), generate, 2 args, luhn, regular" do
    result = capture_io(fn -> run(["generate", "424242424242424"]) end)

    assert result == "2\n"
  end

  test "run(), generate, 2 args, luhn, irregular" do
    result = capture_io(:stderr, fn -> run(["generate", "a"]) end)

    assert result == "failed to generate with seed, message: checkdigit: invalid argument\n"
  end
end
