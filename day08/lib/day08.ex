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

    antenna_name_position_list =
      for x <- 0..(row_count - 1),
          y <- 0..(col_count - 1),
          antenna_name = Enum.at(Enum.at(grid, x), y),
          antenna_name != ".",
          do: {antenna_name, {x, y}}

    antennas_combinations =
      Enum.group_by(
        antenna_name_position_list,
        fn {antenna_name, _position} -> antenna_name end,
        fn {_antenna_name, {x, y}} -> {x, y} end
      )

    antennas_combinations =
      antennas_combinations
      |> Enum.flat_map(fn {_antenna, positions} ->
        Combination.combine(positions, 2)
      end)

    {antenna_name_position_list, antennas_combinations}
  end

  def solve(input) do
    input
    |> read_input()
    |> then(fn {antenna_name_position_list, antennas_combinations} ->
      {antenna_name_position_list, antennas_combinations}

      antenna_positions_map_set =
        antenna_name_position_list
        |> Enum.map(fn {_antenna_name, {x, y}} -> {x, y} end)
        |> MapSet.new()

      antennas_combinations
      |> Enum.flat_map(fn [p1, p2] -> anti_nodes(p1, p2) end)
      |> Enum.uniq()
      |> Enum.reject(fn {x, y} -> x < 0 or y < 0 end)
      |> MapSet.new()
      |> MapSet.difference(antenna_positions_map_set)
      |> Enum.count()
    end)
  end

  def anti_nodes({x1, y1}, {x2, y2}) when x1 < x2 and y1 < y2 do
    [{2 * x1 - x2, 2 * y1 - y2}, {2 * x2 - x1, 2 * y2 - y1}]
  end

  def anti_nodes({x1, y1} = p1, {x2, y2} = p2) when x1 > x2 and y1 > y2 do
    anti_nodes(p2, p1)
  end

  def anti_nodes({x1, y1} = p1, {x2, y2} = p2) when x1 < x2 and y1 > y2 do
    anti_nodes(p2, p1)
    # [{2 * x1 - x2, 2 * y1 - y2}, {2 * x2 - x1, 2 * y2 - y1}]
  end

  def anti_nodes({x1, y1} = p1, {x2, y2} = p2) when x1 > x2 and y1 < y2 do
    [{2 * x2 - x1, 2 * y2 - y1}, {2 * x1 - x2, 2 * y1 - y2}]
  end
end
