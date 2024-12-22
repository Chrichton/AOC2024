defmodule Day08Test do
  use ExUnit.Case
  doctest Day08

  test "read_input" do
    assert Day08.read_input("sample") == [
             [{4, 4}, {3, 7}],
             [{4, 4}, {2, 5}],
             [{3, 7}, {2, 5}],
             [{4, 4}, {1, 8}],
             [{3, 7}, {1, 8}],
             [{2, 5}, {1, 8}],
             [{9, 9}, {8, 8}],
             [{9, 9}, {5, 6}],
             [{8, 8}, {5, 6}]
           ]
  end

  test "sample" do
    assert Day08.solve("sample") == nil
  end

  # test "star" do
  #   assert Day07.solve("star") == 4711
  # end

  # test "sample2" do
  #   assert Day07.solve2("sample") == 6
  # end

  # test "star2" do
  #   # too high
  #   assert Day07.solve2("star") == 1563
  # end
end
