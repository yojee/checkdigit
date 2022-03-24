defmodule Checkdigit.CLI do
  @default_provider :luhn
  def run(argv) do
    IO.inspect(argv)

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

  defp args_to_internal_representation(["verify", seed, provider]) do
    cond do
      verify_provider(provider) -> {:verify, seed, String.to_atom(provider)}
      true -> :help
    end
  end

  defp args_to_internal_representation(["verify", seed]) do
    {:verify, seed, @default_provider}
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
    usage: checkdigit <command> <seed> [ provider | #{@default_provider} ]
    """)
  end

  defp process({:generate, seed, provider}) do
    IO.puts("generating with #{seed} and #{provider}")
  end

  defp process({:verify, seed, provider}) do
    IO.puts("verifyin with #{seed} and #{provider}")
  end
end
