defmodule Exstatic.ContinuousCDF do
  @type t() :: struct()

  @callback cdf(distribution :: t(), x :: float()) :: float()
  @callback sf(distribution :: t(), x :: float()) :: float()
  @callback inverse_cdf(distribution :: t(), p :: float()) ::
              {:ok, float()} | {:error, :invalid_probability}
end
