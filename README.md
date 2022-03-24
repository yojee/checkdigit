# Checkdigit
![Hex.pm](https://img.shields.io/hexpm/v/checkdigit)
![GitHub](https://img.shields.io/github/license/tacomeet/checkdigit)

Provide check digit algorithms and calculators written in Elixir. (Mostly copied [this libraly](https://github.com/osamingo/checkdigit) implemented in Go)

## Installation

The package can be installed
by adding `checkdigit` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:checkdigit, "~> 0.1.0"}
  ]
end
```

Documentation is at <https://hexdocs.pm/checkdigit>.

## Provided methods

### Algorithms

- [Luhn](https://en.wikipedia.org/wiki/Luhn_algorithm)

