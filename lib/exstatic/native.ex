defmodule Exstatic.Native do
  @moduledoc false
  use Rustler, otp_app: :exstatic, crate: "exstatic"

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

  @spec t_pdf(float(), float(), float(), float()) :: float()
  def t_pdf(_mean, _std_dev, _df, _x), do: :erlang.nif_error(:nif_not_loaded)

  @spec t_cdf(float(), float(), float(), float()) :: float()
  def t_cdf(_mean, _std_dev, _df, _x), do: :erlang.nif_error(:nif_not_loaded)

  @spec t_variance(float(), float()) :: {:ok, float()} | {:error, String.t()}
  def t_variance(_std_dev, _df), do: :erlang.nif_error(:nif_not_loaded)
end
