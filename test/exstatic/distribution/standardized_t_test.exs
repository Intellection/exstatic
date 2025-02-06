defmodule Exstatic.Distribution.StandardizedTTest do
  use ExUnit.Case, async: true

  alias Exstatic.Distribution.StandardizedT

  doctest Exstatic.Distribution.StandardizedT

  describe "new/1" do
    test "creates a valid standardized t-distribution" do
      assert {:ok, _t} = StandardizedT.new(5.0)
    end

    test "returns error for invalid degrees of freedom" do
      assert {:error, :invalid_df} = StandardizedT.new(1.0)
      assert {:error, :invalid_df} = StandardizedT.new(0.0)
      assert {:error, :invalid_df} = StandardizedT.new(-5.0)
    end
  end

  describe "mean/1" do
    test "returns 0.0 for any valid standardized t-distribution" do
      {:ok, t} = StandardizedT.new(3.0)
      assert StandardizedT.mean(t) == 0.0

      {:ok, t} = StandardizedT.new(10.0)
      assert StandardizedT.mean(t) == 0.0
    end
  end

  describe "variance/1" do
    test "returns a finite variance when df > 2" do
      {:ok, t} = StandardizedT.new(5.0)
      expected_variance = 5.0 / (5.0 - 2.0)
      assert TestHelper.assert_in_delta(StandardizedT.variance(t), expected_variance)
    end

    test "returns :infinity when 1 < df ≤ 2" do
      {:ok, t} = StandardizedT.new(1.5)
      assert StandardizedT.variance(t) == :infinity
    end
  end

  describe "pdf/2" do
    test "computes valid PDF values" do
      {:ok, t} = StandardizedT.new(5.0)
      assert TestHelper.assert_in_delta(StandardizedT.pdf(t, 0.0), 0.37960669, 1.0e-6)
      assert TestHelper.assert_in_delta(StandardizedT.pdf(t, 1.0), 0.219679797, 1.0e-6)
    end
  end

  describe "cdf/2" do
    test "computes valid CDF values" do
      {:ok, t} = StandardizedT.new(5.0)

      assert TestHelper.assert_in_delta(StandardizedT.cdf(t, 0.0), 0.5, 1.0e-9)
      assert TestHelper.assert_in_delta(StandardizedT.cdf(t, -100.0), 0.0, 1.0e-9)
      assert TestHelper.assert_in_delta(StandardizedT.cdf(t, 100.0), 1.0, 1.0e-9)
    end
  end

  describe "sf/2" do
    test "computes valid SF values" do
      {:ok, t} = StandardizedT.new(5.0)

      assert TestHelper.assert_in_delta(StandardizedT.sf(t, 0.0), 0.5, 1.0e-9)
      assert TestHelper.assert_in_delta(StandardizedT.sf(t, -100.0), 1.0, 1.0e-9)
      assert TestHelper.assert_in_delta(StandardizedT.sf(t, 100.0), 0.0, 1.0e-9)
    end
  end
end
