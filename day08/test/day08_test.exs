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

  test "anti_nodes_left_right" do
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

  test "anti_nodes_right_left" do
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

  test "anti_nodes2_left_right" do
    _grid =
      """
      #.........
      ..........
      .T........
      ..........
      ..T.......
      ..........
      ...#......
      ..........
      ....#.....
      ..........
      """

    assert Day08.anti_nodes2({2, 1}, {4, 2}, 10, 10) == [{8, 4}, {6, 3}, {0, 0}]
  end

  test "anti_nodes2_right_left" do
    _grid =
      """
      ..........
      .........#
      .......T..
      .....T....
      ...#......
      .#........
      ..........
      ..........
      ..........
      ..........
      """

    assert Day08.anti_nodes2({2, 7}, {3, 5}, 10, 10) == [{5, 1}, {4, 3}, {1, 9}]
  end

  # @tag :skip
  test "sample2" do
    assert Day08.solve2("sample") == 34
  end

  test "star2" do
    assert Day08.solve2("star") == 884
  end
end
