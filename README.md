# Exstatic

[![Hex.pm](https://img.shields.io/hexpm/v/exstatic.svg)](https://hex.pm/packages/zappi/exstatic)
[![Docs](https://img.shields.io/badge/hex-docs-blue.svg)](https://zappi.hexdocs.pm/exstatic)

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

- Elixir ~> 1.18

Add `exstatic` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:exstatic, "~> 0.2.0", organization: "zappi"}
  ]
end
```

Precompiled NIF binaries are included in releases for common platforms. Downloading precompiled binaries requires you have read access to this repository,
you must set the environment variable `EXSTATIC_GITHUB_TOKEN` with a GitHub Personal Access Token (PAT) with sufficient privileges - 
please see [here](https://github.com/Intellection/exstatic/blob/main/docs/github_token_guide.md) for more details.


## Documentation

Full documentation can be found at [https://zappi.hexdocs.pm/exstatic](https://zappi.hexdocs.pm/exstatic).

## Development

### Requirements

- Elixir ~> 1.18
- Rust (for compiling NIFs)

### Setup

1. Clone the repository
2. Install dependencies:
   ```bash
   mix deps.get
   ```
3. Compile the project (set `EXSTATIC_BUILD=true` to build Rust code):
   ```bash
   EXSTATIC_BUILD=true mix compile
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

## Releasing
See https://github.com/Intellection/exstatic/blob/main/RELEASE.md.

## License

This project is licensed under the MIT License - see the LICENSE file for details.
