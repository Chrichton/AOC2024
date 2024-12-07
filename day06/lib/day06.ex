defmodule Day06 do
  def read_input(input) do
    lines =
      input
      |> File.read!()
      |> String.split("\n")

    {find_start(lines), find_obstacles(lines), max_x_y(lines)}
  end

  def solve(input) do
    input
    |> read_input()
    |> then(fn {start, obstacles, {max_x, max_y}} ->
      next_step({start, :north}, start, obstacles, max_x, max_y, MapSet.new([start]))
    end)
  end

  def next_step(
        {{x, y} = position, direction} = position_direction,
        last_position,
        obstacles,
        max_x,
        max_y,
        visited
      ) do
    cond do
      x < 0 or y < 0 or x > max_x or y > max_y ->
        MapSet.size(visited)

      MapSet.member?(obstacles, position) ->
        position = last_position
        next_direction = next_direction(direction)
        pd = next_position_direction({position, next_direction})
        next_step(pd, position, obstacles, max_x, max_y, MapSet.put(visited, position))

      true ->
        pd = next_position_direction(position_direction)
        next_step(pd, position, obstacles, max_x, max_y, MapSet.put(visited, position))
    end
  end

  defp next_position_direction({{x, y}, direction}) do
    cond do
      direction == :north -> {{x, y - 1}, :north}
      direction == :south -> {{x, y + 1}, :south}
      direction == :west -> {{x - 1, y}, :west}
      direction == :east -> {{x + 1, y}, :east}
    end
  end

  defp next_direction(direction) do
    cond do
      direction == :north -> :east
      direction == :south -> :west
      direction == :west -> :north
      direction == :east -> :south
    end
  end

  defp find_start(lines) do
    [{x, y}] =
      for {line, y_index} <- Enum.with_index(lines),
          {char, x_index} <- Enum.with_index(String.codepoints(line)),
          char == "^",
          do: {x_index, y_index}

    {x, y}
  end

  defp find_obstacles(lines) do
    for(
      {line, y_index} <- Enum.with_index(lines),
      {char, x_index} <- Enum.with_index(String.codepoints(line)),
      char == "#",
      do: {x_index, y_index}
    )
    |> MapSet.new()
  end

  defp max_x_y(lines) do
    max_x =
      lines
      |> List.first()
      |> String.length()
      |> Kernel.-(1)

    max_y = Enum.count(lines) - 1

    {max_x, max_y}
  end

  # -------------------------------  part 2 ---------------------------------

  def solve2(input) do
    lines =
      input
      |> File.read!()
      |> String.split("\n")

    {find_start(lines), find_obstacles(lines), max_x_y(lines)}
    |> then(fn {start, obstacles, {max_x, max_y}} ->
      for(
        x <- 0..max_x,
        y <- 0..max_y,
        obstacles = MapSet.put(obstacles, {x - 1, y}),
        do: loop?(start, obstacles, max_x, max_y, MapSet.new([{start, :north}]))
      )
      |> Enum.filter(& &1)
      |> Enum.count()
    end)
  end

  defp loop?(start, obstacles, max_x, max_y, visited) do
    obstacles = MapSet.reject(obstacles, fn {x, _y} -> x < 0 end)
    next_step_find_loop?({start, :north}, start, obstacles, max_x, max_y, visited)
  end

  def next_step_find_loop?(
        {{x, y} = position, direction} = position_direction,
        last_position,
        obstacles,
        max_x,
        max_y,
        visited
      ) do
    cond do
      x < 0 or y < 0 or x > max_x or y > max_y ->
        false

      MapSet.member?(obstacles, position) ->
        position = last_position
        next_direction = next_direction(direction)
        pd = next_position_direction({position, next_direction})

        if MapSet.member?(visited, pd),
          do: true,
          else:
            next_step_find_loop?(pd, position, obstacles, max_x, max_y, MapSet.put(visited, pd))

      true ->
        pd = next_position_direction(position_direction)

        if MapSet.member?(visited, pd),
          do: true,
          else:
            next_step_find_loop?(pd, position, obstacles, max_x, max_y, MapSet.put(visited, pd))
    end
  end
end
