defmodule Exstatic.Distribution do
  @type t() :: struct()
  @type error() :: {:error, atom()}
  @type result(t) :: {:ok, t} | error()

  @callback new(mean :: float(), std_dev :: float()) :: result(t())
  @callback mean(distribution :: t()) :: float()
  @callback variance(distribution :: t()) :: float()
  @callback std_dev(distribution :: t()) :: float()
  @callback entropy(distribution :: t()) :: float()
  @callback skewness(distribution :: t()) :: float()
  @callback median(distribution :: t()) :: float()
  @callback mode(distribution :: t()) :: float()
  @callback min(distribution :: t()) :: :neg_infinity | float()
  @callback max(distribution :: t()) :: :infinity | float()
end
