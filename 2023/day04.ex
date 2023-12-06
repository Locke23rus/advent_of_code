defmodule Day04 do
  def part1(input) do
    get_matching_numbers(input)
    |> Enum.map(&if &1 > 1, do: 2 ** (&1 - 1), else: &1)
    |> Enum.sum()
  end

  def part2(input) do
    matching_numbers = get_matching_numbers(input)

    original_cards =
      matching_numbers
      |> Enum.with_index()
      |> Map.new(fn {_, i} -> {i, 1} end)

    matching_numbers
    |> Enum.with_index()
    |> Enum.reduce(original_cards, fn {n, i}, acc ->
      if n > 0 do
        count = Map.get(acc, i, 1)
        1..n |> Enum.reduce(acc, fn j, acc -> Map.update(acc, i + j, count, &(&1 + count)) end)
      else
        acc
      end
    end)
    |> Map.values()
    |> Enum.sum()
  end

  def get_matching_numbers(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      [left, right] = String.split(line, "|")
      [_, left] = String.split(left, ":")

      left_set = MapSet.new(left |> String.trim() |> String.split(~r/\s+/))
      right_set = MapSet.new(right |> String.trim() |> String.split(~r/\s+/))

      MapSet.intersection(left_set, right_set) |> MapSet.size()
    end)
  end
end

input = File.read!("./input/04.txt")

IO.puts(Day04.part1(input))
IO.puts(Day04.part2(input))
