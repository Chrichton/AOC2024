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

  def move_file_blocks_recursive(list, left_index, count) do
    current = Enum.at(list, left_index)

    if current == "." do
      right_index = count - index_of_first_not(Enum.reverse(list), ".") - 1

      if left_index < right_index do
        list
        |> List.replace_at(left_index, Enum.at(list, right_index))
        |> List.replace_at(right_index, ".")
        |> move_file_blocks_recursive(left_index + 1, count)
      else
        Enum.join(list, "")
      end
    else
      move_file_blocks_recursive(list, left_index + 1, count)
    end
  end

  def move_file_blocks(dense_format) do
    list = String.graphemes(dense_format)
    count = Enum.count(list)

    move_file_blocks_recursive(list, 0, count)
  end

  def index_of_first_not(list, char) do
    list
    |> Enum.with_index()
    |> Enum.find(fn {element, _index} -> element != char end)
    |> case do
      nil -> nil
      {_element, index} -> index
    end
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
