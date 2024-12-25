defmodule Exstatic.Continuous do
  @type t() :: struct()

  @callback pdf(distribution :: t(), x :: float()) :: float()
  @callback ln_pdf(distribution :: t(), x :: float()) :: float()
end
