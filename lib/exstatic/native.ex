defmodule Exstatic.Native do
  @moduledoc false
  config = Mix.Project.config()

  use RustlerPrecompiled,
    otp_app: :exstatic,
    crate: "exstatic",
    base_url: "#{config[:source_url]}/releases/download/v#{config[:version]}",
    force_build: System.get_env("EXSTATIC_BUILD") == "true",
    nif_versions: ["2.16"],
    version: config[:version],
    targets: ~w(
      aarch64-apple-darwin
      x86_64-apple-darwin
      aarch64-unknown-linux-gnu
      x86_64-unknown-linux-gnu
    )

  @spec normal_pdf(float(), float(), float()) :: float()
  def normal_pdf(_mean, _std_dev, _x), do: :erlang.nif_error(:nif_not_loaded)

  @spec normal_ln_pdf(float(), float(), float()) :: float()
  def normal_ln_pdf(_mean, _std_dev, _x), do: :erlang.nif_error(:nif_not_loaded)

  @spec normal_cdf(float(), float(), float()) :: float()
  def normal_cdf(_mean, _std_dev, _x), do: :erlang.nif_error(:nif_not_loaded)

  @spec normal_sf(float(), float(), float()) :: float()
  def normal_sf(_mean, _std_dev, _x), do: :erlang.nif_error(:nif_not_loaded)

  @spec normal_inverse_cdf(float(), float(), float()) :: {:ok, float()} | {:error, String.t()}
  def normal_inverse_cdf(_mean, _std_dev, _p), do: :erlang.nif_error(:nif_not_loaded)

  @spec normal_entropy(float()) :: float()
  def normal_entropy(_std_dev), do: :erlang.nif_error(:nif_not_loaded)

  @spec normal_variance(float()) :: float()
  def normal_variance(_std_dev), do: :erlang.nif_error(:nif_not_loaded)

  @spec standardized_t_pdf(float(), float()) :: float()
  def standardized_t_pdf(_df, _x), do: :erlang.nif_error(:nif_not_loaded)

  @spec standardized_t_cdf(float(), float()) :: float()
  def standardized_t_cdf(_df, _x), do: :erlang.nif_error(:nif_not_loaded)

  @spec standardized_t_sf(float(), float()) :: float()
  def standardized_t_sf(_df, _x), do: :erlang.nif_error(:nif_not_loaded)

  @spec standardized_t_variance(float()) :: {:ok, float()} | {:error, String.t()}
  def standardized_t_variance(_df), do: :erlang.nif_error(:nif_not_loaded)
end
