defmodule Day05 do
  def parse_input(input) do
    lines = File.read!(input)
    [rules_str, updates_str] = String.split(lines, "\n\n")

    rules =
      rules_str
      |> String.split("\n")
      |> Enum.map(fn rule_str ->
        [from_str, to_str] = String.split(rule_str, "|")
        {String.to_integer(from_str), String.to_integer(to_str)}
      end)
      |> Enum.group_by(fn {from, _to} -> from end, fn {_from, to} -> to end)

    updates =
      updates_str
      |> String.split("\n")
      |> Enum.map(fn pages_str ->
        String.split(pages_str, ",")
        |> Enum.map(&String.to_integer/1)
      end)

    {rules, updates}
  end

  def solve1(input) do
    parse_input(input)
    |> check_rules_updates()
    |> Enum.filter(fn {result, _} -> result end)
    |> Enum.map(fn {_, update} -> middle_page_number(update) end)
    |> Enum.sum()
  end

  def check_rules_updates({rules, updates}) do
    Enum.map(updates, fn update ->
      check_rules_update({rules, update})
    end)
  end

  def check_rules_update({rules, update}) do
    Enum.reduce_while(update, {MapSet.new(), update}, fn page, {processed_pages, update} ->
      case Map.fetch(rules, page) do
        {:ok, to_be_printed_after_pages} ->
          if MapSet.intersection(processed_pages, MapSet.new(to_be_printed_after_pages)) ==
               MapSet.new() do
            {:cont, {MapSet.put(processed_pages, page), update}}
          else
            {:halt, {false, update}}
          end

        _ ->
          {:cont, {MapSet.put(processed_pages, page), update}}
      end
    end)
  end

  def middle_page_number(update) do
    middle_index = div(Enum.count(update), 2)
    Enum.at(update, middle_index)
  end

  def solve2(input) do
    input
    |> parse_input()
    |> then(fn {rules, updates} ->
      check_rules_updates({rules, updates})
      |> Stream.reject(fn {result, _} -> result end)
      |> Stream.map(fn {_result, update} -> update end)
      |> then(fn updates ->
        find_correctly_ordered_updates({rules, updates})
        |> Stream.map(fn updates ->
          middle_page_number(updates)
        end)
        |> Enum.sum()
      end)
    end)
  end

  def find_correctly_ordered_updates({rules, updates}) do
    Enum.map(updates, fn update ->
      permutations(update)
      |> Enum.reduce_while([], fn permutation, acc ->
        case check_rules_update({rules, permutation}) do
          {false, _} -> {:cont, acc}
          {_, update} -> {:halt, update}
        end
      end)
    end)
  end

  def permutations([]), do: [[]]

  def permutations(list) do
    for elem <- list, rest <- permutations(list -- [elem]), do: [elem | rest]
  end
end
