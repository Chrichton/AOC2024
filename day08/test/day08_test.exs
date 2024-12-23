defmodule Day08Test do
  use ExUnit.Case
  doctest Day08

  @tag :skip
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

  test "anti_nodes1" do
    _grid =
      """
      ..........
      ...#......
      ..........
      ....a.....
      ..........
      .....a....
      ..........
      ......#...
      ..........
      ..........
      """

    assert Day08.anti_nodes({3, 4}, {5, 5}) == [{1, 3}, {7, 6}]
  end

  test "anti_nodes2" do
    _grid =
      """
      ...........#
      ........0...
      .....0......
      ..#.........
      """

    assert Day08.anti_nodes({1, 8}, {2, 5}) == [{0, 11}, {3, 2}]
  end

  test "sample" do
    assert Day08.solve("sample") == 14
  end

  test "star" do
    # too high
    assert Day08.solve("star") == 282
  end

  # test "sample2" do
  #   assert Day08.solve2("sample") == 6
  # end

  # test "star2" do
  #   # too high
  #   assert Day08.solve2("star") == 1563
  # end
end
