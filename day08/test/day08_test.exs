defmodule Day08Test do
  use ExUnit.Case
  doctest Day08

  test "read_input" do
    assert Day08.read_input("sample") ==
             {[
                {"0", {1, 8}},
                {"0", {2, 5}},
                {"0", {3, 7}},
                {"0", {4, 4}},
                {"A", {5, 6}},
                {"A", {8, 8}},
                {"A", {9, 9}}
              ], 12, 12}
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
    assert Day08.solve("star") == 222
  end

  # test "sample2" do
  #   assert Day08.solve2("sample") == 6
  # end

  # test "star2" do
  #   # too high
  #   assert Day08.solve2("star") == 1563
  # end
end
