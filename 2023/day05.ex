defmodule Day05 do
  def part1(input) do
    [seeds | maps] = input |> String.split("\n\n", trim: true)
    [_, seeds] = String.split(seeds, ": ")
    seeds = seeds |> String.split(" ") |> Enum.map(&String.to_integer/1)

    maps |> parse_maps() |> find_lowest_seed(seeds)
  end

  def part2(input) do
    [seeds | maps] = input |> String.split("\n\n", trim: true)
    [_, seeds] = String.split(seeds, ": ")

    seeds =
      seeds
      |> String.split(" ")
      |> Enum.map(&String.to_integer/1)
      |> Enum.chunk_every(2)
      |> Enum.map(fn [start, len] -> [start, start + len - 1] |> Enum.to_list() end)
      |> List.flatten()

    IO.inspect(seeds)

    # seeds = [1, 2]

    maps |> parse_maps() |> find_lowest_seed(seeds)
  end

  def parse_maps(maps_str) do
    maps_str
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
  end

  def find_lowest_seed(list_of_ranges, seeds) do
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
end

input = File.read!("./input/05.txt")

IO.puts(Day05.part1(input))
IO.puts(Day05.part2(input))
