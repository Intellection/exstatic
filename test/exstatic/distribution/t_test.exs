defmodule Exstatic.Distribution.TTest do
  use ExUnit.Case, async: true

  alias Exstatic.Distribution.T

  doctest Exstatic.Distribution.T

  describe "new/3" do
    test "creates a valid t-distribution" do
      assert {:ok, _t} = T.new(0.0, 1.0, 5.0)
    end

    test "returns error for invalid std_dev" do
      assert {:error, :invalid_std_dev} = T.new(0.0, 0.0, 5.0)
    end

    test "returns error for invalid degrees of freedom" do
      assert {:error, :invalid_df} = T.new(0.0, 1.0, 0.0)
      assert {:error, :invalid_df} = T.new(0.0, 1.0, -5.0)
    end
  end

  describe "mean/1" do
    test "returns the mean when df > 1" do
      {:ok, t} = T.new(5.0, 1.0, 3.0)
      assert T.mean(t) == 5.0
    end

    test "returns :undefined when df = 1" do
      {:ok, t} = T.new(5.0, 1.0, 1.0)
      assert T.mean(t) == :undefined
    end

    test "returns :undefined when df < 1" do
      {:ok, t} = T.new(5.0, 1.0, 0.5)
      assert T.mean(t) == :undefined
    end
  end

  describe "variance/1" do
    test "returns a finite variance when df > 2" do
      {:ok, t} = T.new(0.0, 2.0, 5.0)
      expected_variance = 5.0 / (5.0 - 2.0) * (2.0 * 2.0)
      assert TestHelper.assert_in_delta(T.variance(t), expected_variance)
    end

    test "returns :infinity when 1 < df ≤ 2" do
      {:ok, t} = T.new(0.0, 1.0, 1.5)
      assert T.variance(t) == :infinity
    end

    test "returns :undefined when df ≤ 1" do
      {:ok, t} = T.new(0.0, 1.0, 1.0)
      assert T.variance(t) == :undefined
    end
  end

  describe "pdf/2" do
    test "computes valid PDF values" do
      {:ok, t} = T.new(0.0, 1.0, 5.0)
      assert TestHelper.assert_in_delta(T.pdf(t, 0.0), 0.37960669, 1.0e-6)
      assert TestHelper.assert_in_delta(T.pdf(t, 1.0), 0.219679797, 1.0e-6)
    end
  end

  describe "cdf/2" do
    test "computes valid CDF values" do
      {:ok, t} = T.new(0.0, 1.0, 5.0)

      assert TestHelper.assert_in_delta(T.cdf(t, 0.0), 0.5, 1.0e-9)
      assert TestHelper.assert_in_delta(T.cdf(t, -100.0), 0.0, 1.0e-9)
      assert TestHelper.assert_in_delta(T.cdf(t, 100.0), 1.0, 1.0e-9)
    end
  end
end
