defmodule TestHelper do
  def assert_in_delta(actual, expected, delta \\ 1.0e-10) do
    abs(actual - expected) < delta
  end
end

ExUnit.start()
