# Exstatic

[![Hex.pm](https://img.shields.io/hexpm/v/exstatic.svg)](https://hex.pm/packages/exstatic)
[![Docs](https://img.shields.io/badge/hex-docs-blue.svg)](https://hexdocs.pm/exstatic)

Exstatic provides idiomatic Elixir interfaces for working with statistical distributions. Built on top of the battle-tested [statrs](https://docs.rs/statrs) Rust library, it combines Elixir's elegant syntax with Rust's numerical computing capabilities.

## Features

- 📊 Idiomatic Elixir interfaces for probability distributions
- ⚡ Powered by Rust's statrs library for reliable numerical computations
- 🧮 Common statistical operations (PDF, CDF, entropy, etc.)
- 📐 Behaviour-based design following Elixir conventions
- 📚 Extensive documentation and examples

## Usage

```elixir
alias Exstatic.Distribution.Normal

# Create a standard normal distribution
{:ok, dist} = Normal.new(0.0, 1.0)

# Calculate probability density
Normal.pdf(dist, 0.0)
# => 0.3989422804014327

# Get distribution properties
Normal.mean(dist)      # => 0.0
Normal.variance(dist)  # => 1.0
```

## Installation

### Requirements

- Elixir ~> 1.17

Precompiled NIF binaries are included for common platforms. No additional system dependencies are required for normal usage.

Add `exstatic` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:exstatic, "~> 0.1.0"}
  ]
end
```

## Documentation

Full documentation can be found at [https://hexdocs.pm/exstatic](https://hexdocs.pm/exstatic).

## Development

### Requirements

- Elixir ~> 1.17
- Rust (for compiling NIFs)

### Setup

1. Clone the repository
2. Install dependencies:
   ```bash
   mix deps.get
   ```
3. Compile the project:
   ```bash
   mix compile
   ```
4. Run tests:
   ```bash
   mix test
   ```

### Project Structure

- `lib/` - Elixir source code
  - `distribution/` - Probability distribution implementations
  - `native.ex` - NIF interface
- `native/` - Rust NIF implementations
- `test/` - Test suite

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.
