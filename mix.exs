defmodule Exstatic.MixProject do
  use Mix.Project

  @version "0.1.2"
  @repo "Intellection/exstatic"
  @source_url "https://github.com/#{@repo}"

  def project do
    [
      app: :exstatic,
      version: @version,
      elixir: "~> 1.18",
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps(),
      dialyzer: [plt_add_apps: [:mix]],
      description: description(),
      docs: docs(),
      package: package(),
      name: "Exstatic",
      source_url: @source_url,
      repo: @repo,
      test_coverage: [
        summary: [threshold: 90],
        ignore_modules: [
          Exstatic.Native,
          Exstatic.ReleaseHelper
        ]
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp aliases do
    [
      lint: [
        "compile --warnings-as-errors, dialyzer --plt",
        "format",
        "credo --all --mute-exit-status",
        "dialyzer"
      ]
    ]
  end

  defp description do
    "A statistical distribution library for Elixir with native Rust implementations."
  end

  defp docs do
    [
      main: "readme",
      source_ref: "v#{@version}",
      extras: ["README.md", "CHANGELOG.md"]
    ]
  end

  defp package do
    [
      name: "exstatic",
      organization: "zappi",
      files:
        ~w(lib native/exstatic/src native/exstatic/Cargo.toml mix.exs README.md checksum-*.exs),
      licenses: ["MIT"],
      links: %{"GitHub" => @source_url}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:rustler_precompiled, "~> 0.8"},
      {:rustler, ">= 0.0.0", optional: true},
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.4", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.34", only: :dev, runtime: false},
      {:sobelow, "~> 0.13", only: [:dev, :test], runtime: false},
      {:tesla, "~> 1.13.2"},
      {:jason, "~> 1.4"},
      {:mint, "~> 1.0"}
    ]
  end
end
