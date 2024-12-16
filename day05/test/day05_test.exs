defmodule Day05Test do
  use ExUnit.Case

  test "sample" do
    assert Day05.solve1("sample") == 143
  end

  test "star" do
    assert Day05.solve1("star") == 7365
  end

  test "sample2" do
    assert Day05.solve2("sample") == 123
  end

  # @tag :skip
  @tag timeout: :infinity
  test "star2" do
    assert Day05.solve2("star") == 1562
  end
end
