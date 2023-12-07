defmodule Day05 do
  def part1(input) do
    [seeds | maps] = input |> String.split("\n\n", trim: true)
    [_, seeds] = String.split(seeds, ": ")
    seeds = seeds |> String.split(" ") |> Enum.map(&String.to_integer/1)

    list_of_ranges =
      maps
      |> Enum.map(fn map ->
        [_, map] = String.split(map, ":\n")

        map
        |> String.split("\n", trim: true)
        |> Enum.map(fn line ->
          [dst, src, len] =
            line |> String.split(" ", trim: true) |> Enum.map(&String.to_integer/1)

          {dst, src, len}
        end)
      end)

    list_of_ranges
    |> Enum.reduce(seeds, fn ranges, acc ->
      acc
      |> Enum.map(fn seed ->
        ranges
        |> Enum.find_value(fn {dst, src, len} ->
          if seed >= src && seed <= src + len - 1 do
            dst + (seed - src)
          end
        end) || seed
      end)
    end)
    |> Enum.min()
  end

  def part2(input) do
    input
    |> String.split("\n\n", trim: true)
    |> length()
  end
end

input = File.read!("./input/05.txt")

IO.puts(Day05.part1(input))
IO.puts(Day05.part2(input))
