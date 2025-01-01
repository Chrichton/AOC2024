defmodule Day09Test do
  use ExUnit.Case

  test "read_input" do
    assert Day09.read_input("sample") == "2333133121414131402"
  end

  test "to_dense_format" do
    assert Day09.to_dense_format("12345") == "0..111....22222"
  end

  test "dense_format_to_map" do
    assert Day09.dense_format_to_map("12345") == %{
             0 => "1",
             1 => "2",
             2 => "3",
             3 => "4",
             4 => "5"
           }
  end

  test "index_of_last_not" do
    assert Day09.index_of_last_not(%{0 => "1", 1 => ".", 2 => "."}, 2) == 0
  end

  test "move_file_blocks" do
    assert Day09.move_file_blocks("0..111....22222") == "022111222......"
  end

  test "checksum" do
    assert Day09.checksum("0099811188827773336446555566..............") == 1928
  end

  test "sample" do
    assert Day09.solve("sample") == 1928
  end

  test "star" do
    # too low  90167081070
    # correct: 6359213660505
    assert Day09.solve("star") == 6_359_213_660_505
  end

  @tag :skip
  test "sample2" do
    assert Day09.solve2("sample") == 34
  end

  @tag :skip
  test "star2" do
    assert Day09.solve2("star") == 884
  end
end
