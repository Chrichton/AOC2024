defmodule Day06Test do
  use ExUnit.Case

  test "sample" do
    assert Day06.solve("sample") == 41
  end

  test "star" do
    assert Day06.solve("star") == 4711
  end

  test "sample2" do
    assert Day06.solve2("sample") == 6
  end

  test "star2" do
    # too high
    assert Day06.solve2("star") == 1563
  end
end
