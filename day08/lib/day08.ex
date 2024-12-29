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

    {antenna_name_position_list, row_count, col_count}
  end

  def solve(input) do
    input
    |> read_input()
    |> then(fn {antenna_name_position_list, row_count, col_count} ->
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

      antennas_combinations
      |> Enum.flat_map(fn [p1, p2] -> anti_nodes(p1, p2) end)
      |> Enum.uniq()
      |> Enum.filter(fn {x, y} ->
        x in 0..(row_count - 1) and y in 0..(col_count - 1)
      end)
      |> Enum.count()
    end)
  end

  def anti_nodes({x1, y1}, {x2, y2}) when x1 < x2 and y1 < y2 do
    [{2 * x1 - x2, 2 * y1 - y2}, {2 * x2 - x1, 2 * y2 - y1}]
  end

  def anti_nodes({x1, y1} = p1, {x2, y2} = p2) when x1 > x2 and y1 > y2 do
    anti_nodes(p2, p1)
  end

  def anti_nodes({x1, y1}, {x2, y2}) when x1 < x2 and y1 > y2 do
    [{2 * x1 - x2, 2 * y1 - y2}, {2 * x2 - x1, 2 * y2 - y1}]
  end

  def anti_nodes({x1, y1}, {x2, y2}) when x1 > x2 and y1 > y2 do
    [{2 * x2 - x1, 2 * y2 - y1}, {2 * x1 - x2, 2 * y1 - y2}]
  end

  def anti_nodes({x1, y1} = p1, {x2, y2} = p2) when x1 > x2 and y1 < y2 do
    anti_nodes(p2, p1)
  end

  # -----------------------------------Part 2-----------------------------------

  def solve2(input) do
    input
    |> read_input()
    |> then(fn {antenna_name_position_list, row_count, col_count} ->
      antenna_positions =
        antenna_name_position_list
        |> Enum.map(fn {_antenna_name, position} -> position end)

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

      _positions =
        antennas_combinations
        |> Enum.flat_map(fn [p1, p2] -> anti_nodes2(p1, p2, row_count, col_count) end)
        |> Enum.concat(antenna_positions)
        |> Enum.uniq()
        |> Enum.count()

      # for(
      #   x <- 0..(row_count - 1),
      #   y <- 0..(col_count - 1),
      #   do: if(Enum.member?(positions, {x, y}), do: "#", else: ".")
      # )
      # |> Enum.chunk_every(row_count)
      # |> show_grid()
    end)
  end

  def anti_nodes2({x1, y1}, {x2, y2}, row_count, col_count) when x1 < x2 and y1 < y2 do
    dx = x2 - x1
    dy = y2 - y1

    Stream.iterate(1, &(&1 + 1))
    |> Enum.reduce_while([], fn i, acc ->
      x1i = x1 - dx * i
      y1i = y1 - dy * i

      x2i = x2 + dx * i
      y2i = y2 + dy * i

      x1_in_range = x1i in 0..(row_count - 1) and y1i in 0..(col_count - 1)
      x2_in_range = x2i in 0..(row_count - 1) and y2i in 0..(col_count - 1)

      if x1_in_range or x2_in_range do
        acc = if x1_in_range, do: [{x1i, y1i} | acc], else: acc
        acc = if x2_in_range, do: [{x2i, y2i} | acc], else: acc
        {:cont, acc}
      else
        {:halt, acc}
      end
    end)
  end

  def anti_nodes2({x1, y1} = p1, {x2, y2} = p2, row_count, col_count) when x1 > x2 and y1 > y2 do
    anti_nodes2(p2, p1, row_count, col_count)
  end

  def anti_nodes2({x1, y1}, {x2, y2}, row_count, col_count) when x1 < x2 and y1 > y2 do
    dx = x2 - x1
    dy = y1 - y2

    Stream.iterate(1, &(&1 + 1))
    |> Enum.reduce_while([], fn i, acc ->
      x1i = x1 - dx * i
      y1i = y1 + dy * i

      x2i = x2 + dx * i
      y2i = y2 - dy * i

      x1_in_range = x1i in 0..(row_count - 1) and y1i in 0..(col_count - 1)
      x2_in_range = x2i in 0..(row_count - 1) and y2i in 0..(col_count - 1)

      if x1_in_range or x2_in_range do
        acc = if x1_in_range, do: [{x1i, y1i} | acc], else: acc
        acc = if x2_in_range, do: [{x2i, y2i} | acc], else: acc
        {:cont, acc}
      else
        {:halt, acc}
      end
    end)
  end

  def anti_nodes2({x1, y1} = p1, {x2, y2} = p2, row_count, col_count) when x1 > x2 and y1 < y2 do
    anti_nodes2(p2, p1, row_count, col_count)
  end

  # defp show_grid(grid) do
  #   IO.puts("\n")

  #   grid
  #   |> Enum.map(&Enum.join(&1, ""))
  #   |> Enum.join("\n")
  #   |> IO.puts()
  # end
end
