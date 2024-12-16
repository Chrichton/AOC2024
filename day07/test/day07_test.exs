defmodule Day07Test do
  use ExUnit.Case
  doctest Day07

  test "parse" do
    assert Day07.parse_string("1: 2 3 4") == {1, [2, 3, 4]}
  end

  test "sample" do
    assert Day07.solve("sample.txt") == 41
  end

  # test "star" do
  #   assert Day07.solve("star.txt") == 4711
  # end

  # test "sample2" do
  #   assert Day07.solve2("sample.txt") == 6
  # end

  # test "star2" do
  #   # too high
  #   assert Day07.solve2("star.txt") == 1563
  # end
end
