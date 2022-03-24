defmodule Checkdigit.CLI do
  @default_provider :luhn
  def run(argv) do
    argv
    |> parse_args
    |> process
  end

  def parse_args(argv) do
    OptionParser.parse(argv,
      switches: [help: :boolean],
      aliases: [h: :help]
    )
    |> elem(1)
    |> args_to_internal_representation
  end

  defp args_to_internal_representation(["generate", seed, provider]) do
    cond do
      verify_provider(provider) -> {:generate, seed, String.to_atom(provider)}
      true -> :help
    end
  end

  defp args_to_internal_representation(["generate", seed]) do
    {:generate, seed, @default_provider}
  end

  defp args_to_internal_representation(["verify", code, provider]) do
    cond do
      verify_provider(provider) -> {:verify, code, String.to_atom(provider)}
      true -> :help
    end
  end

  defp args_to_internal_representation(["verify", code]) do
    {:verify, code, @default_provider}
  end

  defp args_to_internal_representation(_) do
    :help
  end

  defp verify_provider(provider) do
    case provider do
      "luhn" -> true
      "verhoeff" -> true
      _ -> false
    end
  end

  defp process(:help) do
    IO.puts(:stderr, """
    usage: checkdigit <command> <seed/code> [ provider | #{@default_provider} ]
    """)
  end

  defp process({:verify, code, provider}) do
    IO.puts(verify({code, provider}))
  end

  defp process({:generate, seed, provider}) do
    case generate({seed, provider}) do
      {:ok, checkdigit} when checkdigit > 9 -> IO.puts("X")
      {:ok, checkdigit} -> IO.puts(checkdigit)
      {:error, reason} -> IO.puts(:stderr, "failed to generate with seed, message: #{reason}")
    end
  end

  defp generate({seed, :luhn}) do
    Checkdigit.Luhn.generate(seed)
  end

  defp verify({code, :luhn}) do
    Checkdigit.Luhn.verify(code)
  end
end
