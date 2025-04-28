defmodule Checkdigit.MixProject do
  use Mix.Project

  @description """
    Library to provide check digit algorithms and calculators written by Elixir.
  """

  def project do
    [
      app: :checkdigit,
      version: "0.1.2",
      name: "checkdigit",
      description: @description,
      package: package(),
      source_url: "https://github.com/tacomeet/checkdigit",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  defp package do
    [
      maintainers: ["tacomeet"],
      licenses: ["MIT"],
      links: %{"Github" => "https://github.com/tacomeet/checkdigit"}
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
      {:ex_doc, "~> 0.37"},
      {:earmark, "~> 1.4"}
    ]
  end
end
