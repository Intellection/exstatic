defmodule Exstatic.Distribution do
  @moduledoc """
  A behaviour for probability distributions.
  """
  @type t() :: struct()
  @type error() :: {:error, atom()}

  @callback mean(distribution :: t()) :: float()
  @callback variance(distribution :: t()) :: float() | :undefined | :infinity
  @callback std_dev(distribution :: t()) :: float()
  @callback entropy(distribution :: t()) :: float()
  @callback skewness(distribution :: t()) :: float()
  @callback median(distribution :: t()) :: float()
  @callback mode(distribution :: t()) :: float()
  @callback min(distribution :: t()) :: :neg_infinity | float()
  @callback max(distribution :: t()) :: :infinity | float()
end
