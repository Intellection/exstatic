defmodule Exstatic.Distribution.NormalTest do
  use ExUnit.Case, async: true

  alias Exstatic.Distribution.Normal

  doctest Exstatic.Distribution.Normal

  describe "new/2" do
    test "creates a valid normal distribution" do
      assert {:ok, %Normal{mean: +0.0, std_dev: 1.0}} = Normal.new(0.0, 1.0)
      assert {:ok, %Normal{mean: 10.0, std_dev: 2.5}} = Normal.new(10.0, 2.5)
    end

    test "returns an error for invalid standard deviation" do
      assert {:error, :invalid_std_dev} = Normal.new(0.0, 0.0)
      assert {:error, :invalid_std_dev} = Normal.new(0.0, -1.0)
    end
  end

  describe "standard/0" do
    test "returns a standard normal distribution (mean=0, std_dev=1)" do
      dist = Normal.standard()
      assert dist.mean == 0.0
      assert dist.std_dev == 1.0
    end
  end

  describe "mean/1" do
    test "returns the mean of the distribution" do
      {:ok, dist} = Normal.new(5.0, 1.0)
      assert Normal.mean(dist) == 5.0
    end
  end

  describe "std_dev/1" do
    test "returns the standard deviation of the distribution" do
      {:ok, dist} = Normal.new(5.0, 2.0)
      assert Normal.std_dev(dist) == 2.0
    end
  end

  describe "variance/1" do
    test "computes the variance correctly" do
      {:ok, dist} = Normal.new(0.0, 1.0)
      assert Normal.variance(dist) == 1.0

      {:ok, dist} = Normal.new(0.0, 2.0)
      assert Normal.variance(dist) == 4.0

      {:ok, dist} = Normal.new(0.0, 0.1)
      assert TestHelper.assert_in_delta(Normal.variance(dist), 0.01)
    end
  end

  describe "entropy/1" do
    test "computes the entropy correctly" do
      {:ok, dist} = Normal.new(0.0, 1.0)
      assert TestHelper.assert_in_delta(Normal.entropy(dist), 1.41893853320467274178, 1.0e-15)

      {:ok, dist} = Normal.new(0.0, 10.0)
      assert TestHelper.assert_in_delta(Normal.entropy(dist), 3.721523626198718425798, 1.0e-15)
    end
  end

  describe "skewness/1" do
    test "returns 0 for normal distributions" do
      {:ok, dist} = Normal.new(0.0, 1.0)
      assert Normal.skewness(dist) == 0.0
    end
  end

  describe "median/1" do
    test "returns the mean as the median" do
      {:ok, dist} = Normal.new(0.0, 1.0)
      assert Normal.median(dist) == 0.0

      {:ok, dist} = Normal.new(5.0, 1.0)
      assert Normal.median(dist) == 5.0
    end
  end

  describe "mode/1" do
    test "returns the mean as the mode" do
      {:ok, dist} = Normal.new(0.0, 1.0)
      assert Normal.mode(dist) == 0.0

      {:ok, dist} = Normal.new(5.0, 2.0)
      assert Normal.mode(dist) == 5.0
    end
  end

  describe "min/1 and max/1" do
    test "returns negative and positive infinity respectively" do
      {:ok, dist} = Normal.new(0.0, 1.0)
      assert Normal.min(dist) == :neg_infinity
      assert Normal.max(dist) == :infinity
    end
  end

  describe "pdf/2" do
    test "computes valid probability density function (PDF) values" do
      {:ok, dist} = Normal.new(0.0, 1.0)
      assert TestHelper.assert_in_delta(Normal.pdf(dist, 0.0), 0.3989422804014327, 1.0e-15)
      assert TestHelper.assert_in_delta(Normal.pdf(dist, 1.0), 0.24197072451914337, 1.0e-15)
      assert TestHelper.assert_in_delta(Normal.pdf(dist, -1.0), 0.24197072451914337, 1.0e-15)
    end
  end

  describe "cdf/2" do
    test "computes valid cumulative distribution function (CDF) values" do
      {:ok, dist} = Normal.new(0.0, 1.0)
      assert TestHelper.assert_in_delta(Normal.cdf(dist, 0.0), 0.5, 1.0e-9)
      assert TestHelper.assert_in_delta(Normal.cdf(dist, -5.0), 0.0000002866515718, 1.0e-16)
      assert TestHelper.assert_in_delta(Normal.cdf(dist, 5.0), 0.9999997133484281, 1.0e-16)
    end
  end

  describe "sf/2" do
    test "computes valid survival function (SF) values" do
      {:ok, dist} = Normal.new(0.0, 1.0)
      assert TestHelper.assert_in_delta(Normal.sf(dist, 0.0), 0.5, 1.0e-9)
      assert TestHelper.assert_in_delta(Normal.sf(dist, -5.0), 0.9999997133484281, 1.0e-16)
      assert TestHelper.assert_in_delta(Normal.sf(dist, 5.0), 0.0000002866515718, 1.0e-16)
    end
  end

  describe "ln_pdf/2" do
    test "computes the log probability density function (ln(PDF))" do
      {:ok, dist} = Normal.new(0.0, 1.0)
      expected_ln_pdf = -0.9189385332046727
      assert TestHelper.assert_in_delta(Normal.ln_pdf(dist, 0.0), expected_ln_pdf, 1.0e-9)
    end
  end

  describe "inverse_cdf/2" do
    test "computes the inverse CDF (quantile function) correctly" do
      {:ok, dist} = Normal.new(0.0, 1.0)

      assert {:ok, result} = Normal.inverse_cdf(dist, 0.975)
      assert TestHelper.assert_in_delta(result, 1.959963984540054, 1.0e-9)

      assert {:error, :invalid_probability} = Normal.inverse_cdf(dist, -0.1)
      assert {:error, :invalid_probability} = Normal.inverse_cdf(dist, 1.5)
    end
  end
end
