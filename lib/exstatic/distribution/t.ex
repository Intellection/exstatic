defmodule Exstatic.Distribution.StandardizedT do
  @moduledoc """
  The standardized Student's t-distribution, used in statistical hypothesis testing.

  This implementation ensures that:
  - The mean is always `0.0`.
  - The variance exists for `df > 1` (it is infinite for `1 < df ≤ 2`).
  - The distribution is well-defined only for `df > 1`.

  ## Examples

      iex> alias Exstatic.Distribution.StandardizedT
      iex> {:ok, t} = StandardizedT.new(5.0)
      iex> StandardizedT.mean(t)
      0.0
      iex> pdf = StandardizedT.pdf(t, 0.0)
      iex> TestHelper.assert_in_delta(pdf, 0.37960669, 1.0e-6)
      true
      iex> result = StandardizedT.cdf(t, 0.0)
      iex> TestHelper.assert_in_delta(result, 0.5)
      true
  """

  @behaviour Exstatic.Distribution
  @behaviour Exstatic.ContinuousPDF
  @behaviour Exstatic.ContinuousCDF

  defstruct [:df]

  @type t :: %__MODULE__{df: float()}

  @doc """
  Creates a new standardized Student's t-distribution with the given degrees of freedom.

  ## Parameters
  - `df` - The degrees of freedom (`df > 1` required).

  ## Examples

      iex> alias Exstatic.Distribution.StandardizedT
      iex> StandardizedT.new(5.0)
      {:ok, %StandardizedT{df: 5.0}}

      iex> StandardizedT.new(1.0)
      {:error, :invalid_df}

      iex> StandardizedT.new(-5.0)
      {:error, :invalid_df}
  """
  def new(df) when is_number(df) and df > 1 do
    {:ok, %__MODULE__{df: df}}
  end

  def new(_df), do: {:error, :invalid_df}

  @doc """
  Returns the mean of the t-distribution.

  The mean is always `0.0` for standardized t-distributions since `df > 1`.

  ## Examples

      iex> {:ok, t} = StandardizedT.new(5.0)
      iex> StandardizedT.mean(t)
      0.0
  """
  @impl Exstatic.Distribution
  def mean(_t), do: 0.0

  @doc """
  Returns the variance of the t-distribution.

  - If `1 < df ≤ 2`, the variance is `:infinity`.
  - Otherwise, the variance is computed using `Exstatic.Native.standardized_t_variance/1`.

  ## Examples

      iex> {:ok, t} = StandardizedT.new(5.0)
      iex> TestHelper.assert_in_delta(StandardizedT.variance(t), 5.0 / (5.0 - 2.0), 1.0e-10)
      true

      iex> {:ok, t} = StandardizedT.new(1.5)
      iex> StandardizedT.variance(t)
      :infinity
  """
  @impl Exstatic.Distribution
  @spec variance(t) :: float() | :infinity
  def variance(%__MODULE__{df: df}) do
    if df <= 2.0, do: :infinity, else: Exstatic.Native.standardized_t_variance(df)
  end

  @doc """
  Computes the probability density function (PDF) at `x`.

  ## Examples

      iex> {:ok, t} = StandardizedT.new(5.0)
      iex> TestHelper.assert_in_delta(StandardizedT.pdf(t, 0.0), 0.37960669, 1.0e-6)
      true
  """
  @impl Exstatic.ContinuousPDF
  def pdf(%__MODULE__{} = dist, x) when is_number(x) do
    Exstatic.Native.standardized_t_pdf(dist.df, x)
  end

  @doc """
  Computes the cumulative distribution function (CDF) at `x`.

  ## Examples

      iex> {:ok, t} = StandardizedT.new(5.0)
      iex> TestHelper.assert_in_delta(StandardizedT.cdf(t, 0.0), 0.5, 1.0e-10)
      true
  """
  @impl Exstatic.ContinuousCDF
  def cdf(%__MODULE__{} = dist, x) when is_number(x) do
    Exstatic.Native.standardized_t_cdf(dist.df, x)
  end

  @doc """
  Computes the survival function (SF) at `x`, which is `1 - CDF(x)`.

  ## Examples

      iex> {:ok, t} = StandardizedT.new(5.0)
      iex> TestHelper.assert_in_delta(StandardizedT.sf(t, 0.0), 0.5, 1.0e-10)
      true
  """
  @impl Exstatic.ContinuousCDF
  def sf(%__MODULE__{} = dist, x) when is_number(x) do
    Exstatic.Native.standardized_t_sf(dist.df, x)
  end
end
