defmodule Exstatic.Continuous do
  @moduledoc """
  Defines the behaviour for continuous probability distributions that support 
  probability density function (PDF) calculations.

  A continuous probability distribution is characterised by its probability 
  density function (PDF), which describes the likelihood of different values 
  occurring. 

  This behaviour is implemented by distributions that can compute:

  - `pdf/2` – the probability density at a given `x`
  - `ln_pdf/2` – the natural logarithm of the probability density, often used 
  for numerical stability.
  """
  @type t() :: struct()

  @callback pdf(distribution :: t(), x :: float()) :: float()
  @callback ln_pdf(distribution :: t(), x :: float()) :: float()
end
