defmodule Day04 do
  def part1(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      [left, right] = String.split(line, "|")
      [_, left] = String.split(left, ":")

      left_set = MapSet.new(left |> String.trim() |> String.split(~r/\s+/))
      right_set = MapSet.new(right |> String.trim() |> String.split(~r/\s+/))

      common = MapSet.intersection(left_set, right_set) |> MapSet.size()

      if common > 1, do: 2 ** (common - 1), else: common
    end)
    |> Enum.sum()
  end

  def part2(input) do
    input
    |> String.split("\n", trim: true)
    |> length()
  end
end

input = File.read!("./input/04.txt")

IO.puts(Day04.part1(input))
IO.puts(Day04.part2(input))
