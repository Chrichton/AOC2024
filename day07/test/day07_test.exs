defmodule Day07Test do
  use ExUnit.Case
  doctest Day07

  test "parse" do
    assert Day07.parse_string("1: 2 3 4") == {1, [2, 3, 4]}
  end

  test "read_input sample" do
    assert Day07.read_input("sample.txt") == [
             {190, [10, 19]},
             {3267, [81, 40, 27]},
             {83, [17, 5]},
             {156, [15, 6]},
             {7290, [6, 8, 6, 15]},
             {161_011, [16, 10, 13]},
             {192, [17, 8, 14]},
             {21037, [9, 7, 18, 13]},
             {292, [11, 6, 16, 20]}
           ]
  end

  test "calculate_result +*" do
    assert Day07.calculate_result(
             [3, 2, 4],
             [fn x, y -> x + y end, fn x, y -> x * y end]
           ) == 20
  end

  test "calculate_result *+" do
    assert Day07.calculate_result(
             [3, 2, 4],
             [fn x, y -> x * y end, fn x, y -> x + y end]
           ) == 10
  end

  test "sample" do
    assert Day07.solve("sample.txt") == 3749
  end

  test "star" do
    assert Day07.solve("star.txt") == 850_435_817_339
  end

  # ---------------- For Part2 ----------------
  # def operations(params) do
  # operations_map = operations_map_part2()

  # test "sample2" do
  #   assert Day07.solve2("sample.txt") == 11387
  # end

  # test "star2" do
  #   # too high
  #   assert Day07.solve2("star.txt") == 104_824_810_233_437
  # end
end
