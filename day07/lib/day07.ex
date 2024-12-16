defmodule Day07 do
  defmodule Combinatorics do
    def permutations_with_repetition(list, length) do
      Enum.flat_map(list, fn x ->
        permutations_with_repetition(Enum.drop(list, 0), length - 1, [x])
      end)
    end

    defp permutations_with_repetition(list, length, prefix) do
      case length do
        0 ->
          [prefix]

        _ ->
          Enum.flat_map(list, fn x ->
            permutations_with_repetition(list, length - 1, prefix ++ [x])
          end)
      end
    end

    def permutations(list, length) do
      combinations(list, length)
      |> Enum.flat_map(fn combo ->
        permute(combo)
      end)
    end

    defp permute(list) do
      case list do
        [] ->
          [[]]

        [x | xs] ->
          Enum.flat_map(permute(xs), fn p ->
            Enum.map(0..length(p), fn i ->
              List.insert_at(p, i, x)
            end)
          end)
      end
    end

    def combinations(list, length) do
      case length do
        0 ->
          [[]]

        _ ->
          list
          |> Enum.reduce([], fn x, acc ->
            (combinations(
               Enum.drop(list, Enum.find_index(list, fn y -> y == x end) + 1),
               length - 1
             )
             |> Enum.map(fn c -> [x | c] end)) ++ acc
          end)
      end
    end

    # Example usage:
    # my_list = [1, 2, 3, 4]

    # permutations = Combinatorics.permutations_with_repetition(my_list, 2)
    # IO.inspect(permutations)
    # Output: [[1, 1], [1, 2], [1, 3], [1, 4], [2, 1], [2, 2], [2, 3], [2, 4], [3, 1], [3, 2], [3, 3], [3, 4], [4, 1], [4, 2], [4, 3], [4, 4]]

    # combinations = Combinatorics.combinations(my_list, 2)
    # IO.inspect(combinations)
    # Output: [[1, 2], [1, 3], [1, 4], [2, 3], [2, 4], [3, 4]]

    # permutations = Combinatorics.permutations(my_list, 2)
    # IO.inspect(permutations)
    # Output: [[1, 2], [2, 1], [1, 3], [3, 1], [1, 4], [4, 1], [2, 3], [3, 2], [2, 4], [4, 2], [3, 4], [4, 3]]
  end

  # @number_to_operator %{
  #   1 => fn x, y -> x + y end,
  #   2 => fn x, y -> x * y end,
  #   3 => fn x, y -> x - y end,
  #   4 => fn x, y -> x / y end
  # }

  def read_input(input) do
    input
    |> File.read!()
    |> String.split("\n")
    |> Enum.map(&parse_string/1)
  end

  def parse_string(str) do
    [head, tail] = String.split(str, ": ")

    {String.to_integer(head),
     String.split(tail, " ")
     |> Enum.map(&String.to_integer/1)}
  end

  def solve(input) do
    input
    |> read_input()
    |> Enum.map(fn {_test_value, numbers} ->
      operations(numbers)
      # IO.inspect(combinations, label: "combinations")
      # |> Enum.reduce(0, fn -> {op1.(b, c), op2.(b, d)} end)

      # |> Enum.map(fn {x, y} -> op1.(x, y) end)
    end)
  end

  def can_numbers_produce_test_value?(test_value, numbers) do
    operations(numbers)
    |> Enum.reduce_while(false, fn operation, _acc ->
      result = calculate_result(numbers, operation)

      if result == test_value,
        do: {:halt, true},
        else: {:cont, false}
    end)
  end

  def calculate_result(numbers, operation) do
    numbers
    |> Enum.reduce(0, fn number, result ->
      operation.(result, number)
    end)
  end

  def operations_map() do
    %{
      1 => fn x, y -> x + y end,
      2 => fn x, y -> x * y end,
      3 => fn x, y -> x - y end,
      4 => fn x, y -> x / y end
    }
  end

  def operations(params) do
    IO.inspect(params, label: "params")
    operations_map = operations_map()

    Day07.Combinatorics.permutations_with_repetition(1..4, Enum.count(params) - 1)
    |> Enum.flat_map(fn operator_indices ->
      Enum.map(operator_indices, fn operator_index ->
        operations_map[operator_index]
      end)

      # |> Enum.reduce(0, fn _operation, acc ->
      #   acc
      # end)
    end)
  end
end

[[1.85188841], [2.85188841], [3.85188841], [4.85188841]]
