defmodule Exstatic.Native do
  @moduledoc false
  version = Mix.Project.config()[:version]

  use RustlerPrecompiled,
    otp_app: :exstatic,
    crate: "exstatic",
    base_url: "https://github.com/intellection/exstatic/releases/download/v#{version}",
    force_build: System.get_env("EXSTATIC_BUILD") == "true",
    nif_versions: ["2.16"],
    version: version

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
