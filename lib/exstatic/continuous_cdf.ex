defmodule Exstatic.ContinuousCDF do
  @moduledoc """
  Defines the behaviour for continuous probability distributions that support 
  cumulative distribution function (CDF) and related calculations.

  A cumulative distribution function (CDF) describes the probability that 
  a random variable is less than or equal to a given value. This behaviour also 
  supports related functions:

  - `cdf/2` – computes P(X ≤ x), the cumulative probability.
  - `sf/2` – computes P(X > x), also known as the survival function (SF).
  - `inverse_cdf/2` – computes the quantile function, which finds `x` such 
  that P(X ≤ x) = p.
  """
  @type t() :: struct()

  @callback cdf(distribution :: t(), x :: float()) :: float()
  @callback sf(distribution :: t(), x :: float()) :: float()
  @callback inverse_cdf(distribution :: t(), p :: float()) ::
              {:ok, float()} | {:error, :invalid_probability}
end
