defmodule Day05 do
  def part1(input) do
    [seeds | maps] = input |> String.split("\n\n", trim: true)
    [_, seeds] = String.split(seeds, ": ")
    seeds = seeds |> String.split(" ") |> Enum.map(&String.to_integer/1)

    list_of_maps =
      maps
      |> Enum.map(fn map ->
        [_, map] = String.split(map, ":\n")

        ranges =
          map
          |> String.split("\n", trim: true)
          |> Enum.map(fn line ->
            [dst, src, len] =
              line |> String.split(" ", trim: true) |> Enum.map(&String.to_integer/1)

            {dst, src, len}
          end)

        ranges
        |> Enum.reduce(%{}, fn {dst, src, len}, acc ->
          0..(len - 1) |> Enum.reduce(acc, fn i, acc -> Map.put(acc, src + i, dst + i) end)
        end)
      end)

    list_of_maps
    |> Enum.reduce(seeds, fn map, acc -> acc |> Enum.map(&Map.get(map, &1, &1)) end)
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
