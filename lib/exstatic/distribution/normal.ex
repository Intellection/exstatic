defmodule Exstatic.Distribution.Normal do
  @moduledoc """
  Normal (Gaussian) distribution implementation.

  The normal distribution is a continuous probability distribution defined by
  its mean and standard deviation.

  ## Examples

      iex> alias Exstatic.Distribution.Normal
      iex> {:ok, n} = Normal.new(0.0, 1.0)
      iex> Normal.mean(n)
      0.0
      iex> pdf = Normal.pdf(n, 0.0)
      iex> TestHelper.assert_in_delta(pdf, 0.3989422804014327)
      true
      iex> result = Normal.cdf(n, 0.0)
      iex> TestHelper.assert_in_delta(result, 0.5)
      true
  """

  @behaviour Exstatic.Distribution
  @behaviour Exstatic.ContinuousPDF
  @behaviour Exstatic.ContinuousCDF

  defstruct [:mean, :std_dev]

  @type t :: %__MODULE__{
          mean: float(),
          std_dev: float()
        }

  @doc """
  Creates a new normal distribution with given mean and standard deviation.

  ## Parameters
  * `mean` - The mean (μ) of the distribution
  * `std_dev` - The standard deviation (σ) of the distribution

  ## Examples

      iex> alias Exstatic.Distribution.Normal
      iex> Normal.new(0.0, 1.0)
      {:ok, %Normal{mean: 0.0, std_dev: 1.0}}

      iex> Normal.new(10.0, 2.5)
      {:ok, %Normal{mean: 10.0, std_dev: 2.5}}

      iex> Normal.new(0.0, 0.0)
      {:error, :invalid_std_dev}

      iex> Normal.new(0.0, -1.0)
      {:error, :invalid_std_dev}
  """
  def new(mean, std_dev) when is_number(mean) and is_number(std_dev) do
    if std_dev <= 0 do
      {:error, :invalid_std_dev}
    else
      {:ok, %__MODULE__{mean: mean, std_dev: std_dev}}
    end
  end

  @doc """
  Creates a standard normal distribution with mean 0 and standard deviation 1.
  """
  def standard(), do: %__MODULE__{mean: 0.0, std_dev: 1.0}

  @impl Exstatic.Distribution
  def mean(%__MODULE__{mean: mean}), do: mean

  @impl Exstatic.Distribution
  def std_dev(%__MODULE__{std_dev: std_dev}), do: std_dev

  @doc """
  Calculates the probability density function (PDF) at x.

  ## Examples

      iex> {:ok, n} = Normal.new(10.0, 0.1)
      iex> TestHelper.assert_in_delta(Normal.pdf(n, 8.5), 5.530709549844416159162E-49, 1.0e-64)
      true

      iex> {:ok, n} = Normal.new(10.0, 0.1)
      iex> TestHelper.assert_in_delta(Normal.pdf(n, 10.0), 3.989422804014326779399, 1.0e-15)
      true

      iex> {:ok, n} = Normal.new(-5.0, 1.0)
      iex> TestHelper.assert_in_delta(Normal.pdf(n, -5.0), 0.3989422804014326779399, 1.0e-16)
      true

      iex> {:ok, n} = Normal.new(0.0, 10.0)
      iex> TestHelper.assert_in_delta(Normal.pdf(n, 0.0), 0.03989422804014326779399, 1.0e-17)
      true
  """
  @impl Exstatic.ContinuousPDF
  def pdf(%__MODULE__{} = dist, x) when is_number(x) do
    Exstatic.Native.normal_pdf(dist.mean, dist.std_dev, x)
  end

  @doc """
  Calculates the cumulative distribution function (CDF) at x.

  ## Examples

      iex> {:ok, n} = Normal.new(5.0, 2.0)
      iex> TestHelper.assert_in_delta(Normal.cdf(n, -5.0), 0.0000002866515718, 1.0e-16)
      true

      iex> {:ok, n} = Normal.new(5.0, 2.0)
      iex> TestHelper.assert_in_delta(Normal.cdf(n, 5.0), 0.5, 1.0e-15)
      true

      iex> {:ok, n} = Normal.new(5.0, 2.0)
      iex> TestHelper.assert_in_delta(Normal.cdf(n, 10.0), 0.993790334674, 1.0e-12)
      true
  """
  @impl Exstatic.ContinuousCDF
  def cdf(%__MODULE__{} = dist, x) when is_number(x) do
    Exstatic.Native.normal_cdf(dist.mean, dist.std_dev, x)
  end

  @doc """
  Returns the variance of the normal distribution.

  ## Examples

      iex> n = Normal.standard()
      iex> Normal.variance(n)
      1.0

      iex> {:ok, n} = Normal.new(0.0, 0.1)
      iex> TestHelper.assert_in_delta(Normal.variance(n), 0.01)
      true

      iex> {:ok, n} = Normal.new(0.0, 10.0)
      iex> Normal.variance(n)
      100.0
  """
  @impl Exstatic.Distribution
  def variance(%__MODULE__{std_dev: std_dev}) do
    Exstatic.Native.normal_variance(std_dev)
  end

  @doc """
  Returns the entropy of the normal distribution.

  ## Examples

      iex> {:ok, n} = Normal.new(0.0, 0.1)
      iex> TestHelper.assert_in_delta(Normal.entropy(n), -0.8836465597893729422377, 1.0e-15)
      true

      iex> {:ok, n} = Normal.new(0.0, 1.0)
      iex> TestHelper.assert_in_delta(Normal.entropy(n), 1.41893853320467274178, 1.0e-15)
      true

      iex> {:ok, n} = Normal.new(0.0, 10.0)
      iex> TestHelper.assert_in_delta(Normal.entropy(n), 3.721523626198718425798, 1.0e-15)
      true
  """
  @impl Exstatic.Distribution
  def entropy(%__MODULE__{std_dev: std_dev}) do
    Exstatic.Native.normal_entropy(std_dev)
  end

  @doc """
  Returns the skewness of the normal distribution.
  For a normal distribution, this is always 0.0.

  ## Examples

      iex> {:ok, n} = Normal.new(0.0, 0.1)
      iex> Normal.skewness(n)
      0.0

      iex> {:ok, n} = Normal.new(4.0, 1.0)
      iex> Normal.skewness(n)
      0.0

      iex> {:ok, n} = Normal.new(0.3, 10.0)
      iex> Normal.skewness(n)
      0.0
  """
  @impl Exstatic.Distribution
  def skewness(%__MODULE__{}), do: 0.0

  @doc """
  Returns the median of the normal distribution.
  For a normal distribution, this equals the mean.

  ## Examples

      iex> {:ok, n} = Normal.new(0.0, 1.0)
      iex> Normal.median(n)
      0.0

      iex> {:ok, n} = Normal.new(0.1, 1.0)
      iex> Normal.median(n)
      0.1

      iex> {:ok, n} = Normal.new(-10.0, 1.0)
      iex> Normal.median(n)
      -10.0
  """
  @impl Exstatic.Distribution
  def median(%__MODULE__{mean: mean}), do: mean

  @doc """
  Returns the mode of the normal distribution.
  For a normal distribution, this equals the mean.

  ## Examples

      iex> {:ok, n} = Normal.new(0.0, 1.0)
      iex> Normal.mode(n)
      0.0

      iex> {:ok, n} = Normal.new(0.1, 1.0)
      iex> Normal.mode(n)
      0.1

      iex> {:ok, n} = Normal.new(-10.0, 1.0)
      iex> Normal.mode(n)
      -10.0
  """
  @impl Exstatic.Distribution
  def mode(%__MODULE__{mean: mean}), do: mean

  @doc """
  Returns the minimum value in the domain of the distribution.

  ## Examples

      iex> {:ok, n} = Normal.new(0.0, 0.1)
      iex> Normal.min(n)
      :neg_infinity

      iex> {:ok, n} = Normal.new(-3.0, 10.0)
      iex> Normal.min(n)
      :neg_infinity
  """
  @impl Exstatic.Distribution
  def min(%__MODULE__{}), do: :neg_infinity

  @doc """
  Returns the maximum value in the domain of the distribution.

  ## Examples

      iex> {:ok, n} = Normal.new(0.0, 0.1)
      iex> Normal.max(n)
      :infinity

      iex> {:ok, n} = Normal.new(-3.0, 10.0)
      iex> Normal.max(n)
      :infinity
  """
  @impl Exstatic.Distribution
  def max(%__MODULE__{}), do: :infinity

  @doc """
  Calculates the log probability density function (ln(PDF)) at x.

  ln(PDF(x)) = -ln(σ√(2π)) - (x-μ)²/(2σ²)
  where μ is the mean and σ is the standard deviation

  ## Parameters
    * `dist` - Normal distribution struct
    * `x` - Point at which to evaluate the ln(PDF)

  ## Examples
      iex> dist = Normal.standard()
      iex> result = Normal.ln_pdf(dist, 0.0)
      iex> TestHelper.assert_in_delta(result, -0.9189385332046727) # approximately -ln(√(2π))
      true
  """
  @impl Exstatic.ContinuousPDF
  def ln_pdf(%__MODULE__{} = dist, x) when is_number(x) do
    Exstatic.Native.normal_ln_pdf(dist.mean, dist.std_dev, x)
  end

  @doc """
  Calculates the survival function (SF) at x.

  ## Examples

      iex> {:ok, n} = Normal.new(5.0, 2.0)
      iex> TestHelper.assert_in_delta(Normal.sf(n, -5.0), 0.9999997133484281, 1.0e-16)
      true

      iex> {:ok, n} = Normal.new(5.0, 2.0)
      iex> TestHelper.assert_in_delta(Normal.sf(n, 5.0), 0.5, 1.0e-15)
      true

      iex> {:ok, n} = Normal.new(5.0, 2.0)
      iex> TestHelper.assert_in_delta(Normal.sf(n, 10.0), 0.006209665325512148, 1.0e-12)
      true
  """
  @impl Exstatic.ContinuousCDF
  def sf(%__MODULE__{} = dist, x) when is_number(x) do
    Exstatic.Native.normal_sf(dist.mean, dist.std_dev, x)
  end

  @doc """
  Calculates the inverse cumulative distribution function (inverse CDF) at p.
  Also known as the quantile function.

  ## Parameters
    * `dist` - Normal distribution struct
    * `p` - Probability value between 0 and 1

  ## Examples
      iex> dist = Normal.standard()
      iex> {:ok, result} = Normal.inverse_cdf(dist, 0.975)
      iex> TestHelper.assert_in_delta(result, 1.959963984540054)
      true

      iex> dist = Normal.standard()
      iex> Normal.inverse_cdf(dist, 1.5)
      {:error, :invalid_probability}

      iex> dist = Normal.standard()
      iex> Normal.inverse_cdf(dist, -0.1)
      {:error, :invalid_probability}

  ## Errors
      Returns {:error, :invalid_probability} if p is not in [0,1]
  """
  @impl Exstatic.ContinuousCDF
  def inverse_cdf(%__MODULE__{} = dist, p) when is_number(p) do
    if p >= 0 and p <= 1 do
      {:ok, Exstatic.Native.normal_inverse_cdf(dist.mean, dist.std_dev, p)}
    else
      {:error, :invalid_probability}
    end
  end
end
