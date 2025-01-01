defmodule Day09 do
  def read_input(input) do
    input
    |> File.read!()
  end

  def from_dense_format(input) do
    flip_stream =
      Stream.iterate(:file_length, fn flip ->
        if flip == :file_length,
          do: :free_space_lenght,
          else: :file_length
      end)

    Enum.zip(flip_stream, String.graphemes(input))
    |> Enum.reduce({"", 0}, fn {flip, number_char}, {acc, file_id} ->
      count = String.to_integer(number_char)

      if flip == :file_length,
        do: {acc <> String.duplicate(file_id |> Integer.to_string(), count), file_id + 1},
        else: {acc <> String.duplicate(".", count), file_id}
    end)
    |> elem(0)
  end

  def dense_format_to_map(dense_format) do
    dense_format
    |> String.graphemes()
    |> Enum.with_index()
    |> Map.new(fn {value, key} -> {key, value} end)
  end

  def map_to_dense_format(map) do
    map
    |> Map.keys()
    |> Enum.sort(:asc)
    |> Enum.map(fn key -> map[key] end)
    |> Enum.join()
  end

  def move_file_blocks_recursive(map, left_index, right_index)
      when left_index >= right_index,
      do: map_to_dense_format(map)

  def move_file_blocks_recursive(map, left_index, right_index) do
    if map[left_index] == "." do
      Map.put(map, left_index, map[right_index])
      |> Map.put(right_index, ".")
      |> move_file_blocks_recursive(
        left_index + 1,
        index_of_last_not(map, right_index - 1)
      )
    else
      move_file_blocks_recursive(map, left_index + 1, index_of_last_not(map, right_index))
    end
  end

  def move_file_blocks(dense_format) do
    map = dense_format_to_map(dense_format)
    max_index = String.length(dense_format) - 1
    right_index = index_of_last_not(map, max_index)

    move_file_blocks_recursive(map, 0, right_index)
  end

  def index_of_last_not(map, right_index) do
    right_index..0
    |> Stream.drop_while(fn index -> map[index] == "." end)
    |> Enum.take(1)
    |> hd()
  end

  def checksum(block_string) do
    block_string
    |> String.graphemes()
    |> Enum.with_index(fn char, index ->
      if char == ".", do: 0, else: index * String.to_integer(char)
    end)
    |> Enum.sum()
  end

  def solve(input) do
    input
    |> read_input()
    |> from_dense_format()
    |> move_file_blocks()
    |> checksum()
  end

  def solve2(input) do
    input
    |> read_input()
  end
end
