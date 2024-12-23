defmodule Day08 do
  def read_input(input) do
    input
    |> File.read!()
    |> String.split("\n")
    |> Enum.map(&String.graphemes/1)
    |> parse_grid()
  end

  def parse_grid(grid) do
    row_count = Enum.count(grid)
    col_count = Enum.count(Enum.at(grid, 0))

    antennas =
      for x <- 0..(row_count - 1),
          y <- 0..(col_count - 1),
          Enum.at(Enum.at(grid, x), y) != ".",
          do: {x, y}

    antenna_pairs =
      Enum.group_by(antennas, fn {x, y} ->
        Enum.at(Enum.at(grid, x), y)
      end)
      |> Enum.flat_map(fn {_antenna, positions} ->
        Combination.combine(positions, 2)
      end)

    antenna_pairs
  end

  def solve(input) do
    input
    |> read_input()
  end

  def anti_nodes({x1, y1}, {x2, y2}) when x1 < x2 and y1 < y2 do
    [{2 * x2 - x1}, {2 * y2 - y1}]
  end

  def anti_nodes({x1, y1} = p1, {x2, y2} = p2) when x1 > x2 and y1 > y2 do
    anti_nodes(p2, p1)
  end

  def anti_nodes({x1, y1}, {x2, y2}) when x1 < x2 and y1 > y2 do
    [{2 * x2 - x1}, {2 * y1 - y2}]
  end

  def anti_nodes({x1, y1}, {x2, y2}) when x1 > x2 and y1 < y2 do
    [{2 * x1 - x2}, {2 * y2 - y1}]
  end
end
