defmodule Exstatic.Distribution.T do
  @moduledoc """
  Student's t-distribution implementation.
  """

  @behaviour Exstatic.Distribution
  @behaviour Exstatic.Continuous
  @behaviour Exstatic.ContinuousCDF

  defstruct [:mean, :std_dev, :df]

  @type t :: %__MODULE__{
          mean: float(),
          std_dev: float(),
          df: float()
        }

  def new(mean, std_dev, df) when is_number(mean) and is_number(std_dev) and is_number(df) do
    cond do
      std_dev <= 0 -> {:error, :invalid_std_dev}
      df <= 0 -> {:error, :invalid_df}
      true -> {:ok, %__MODULE__{mean: mean, std_dev: std_dev, df: df}}
    end
  end

  @impl Exstatic.Distribution
  def mean(%__MODULE__{mean: mean, df: df}) do
    if df > 1, do: mean, else: :undefined
  end

  @impl Exstatic.Distribution
  def std_dev(%__MODULE__{std_dev: std_dev}), do: std_dev

  @impl Exstatic.Distribution
  @spec variance(t) :: float() | :infinity | :undefined
  def variance(%__MODULE__{std_dev: std_dev, df: df}) do
    cond do
      df <= 1.0 -> :undefined
      df > 1.0 and df <= 2.0 -> :infinity
      true -> Exstatic.Native.t_variance(std_dev, df)
    end
  end

  @impl Exstatic.Continuous
  def pdf(%__MODULE__{} = dist, x) when is_number(x) do
    Exstatic.Native.t_pdf(dist.mean, dist.std_dev, dist.df, x)
  end

  @impl Exstatic.ContinuousCDF
  def cdf(%__MODULE__{} = dist, x) when is_number(x) do
    Exstatic.Native.t_cdf(dist.mean, dist.std_dev, dist.df, x)
  end
end
