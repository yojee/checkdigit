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
- [Verhoeff](https://en.wikipedia.org/wiki/Verhoeff_algorithm)
- [Damm](https://en.wikipedia.org/wiki/Damm_algorithm)


### Calculators

- [ISBN-10](https://en.wikipedia.org/wiki/International_Standard_Book_Number)
- [ISBN-13](https://en.wikipedia.org/wiki/International_Standard_Book_Number)
- [EAN-8](https://en.wikipedia.org/wiki/EAN-8)
- [EAN-8](https://en.wikipedia.org/wiki/EAN-8)
- [EAN-13](https://en.wikipedia.org/wiki/EAN-13)
- [JAN-8](https://en.wikipedia.org/wiki/Japanese_Article_Number)
- [JAN-13](https://en.wikipedia.org/wiki/Japanese_Article_Number)
- [ITF](https://en.wikipedia.org/wiki/Interleaved_2_of_5)
- [UPC](https://en.wikipedia.org/wiki/Universal_Product_Code)
- [SSCC](https://en.wikipedia.org/wiki/Serial_Shipping_Container_Code)
