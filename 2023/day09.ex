defmodule Day09 do
  def part1(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      line
      |> String.split(" ", trim: true)
      |> Enum.map(&String.to_integer/1)
      |> Stream.iterate(fn prev_list ->
        Enum.chunk_every(prev_list, 2, 1, :discard)
        |> Enum.map(fn [a, b] -> b - a end)
      end)
      |> Enum.take_while(fn list -> Enum.any?(list, &(&1 != 0)) end)
      |> Enum.map(&List.last/1)
      |> Enum.sum()
    end)
    |> Enum.sum()
  end

  def part2(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      line
      |> String.split(" ", trim: true)
      |> Enum.map(&String.to_integer/1)
      |> Stream.iterate(fn prev_list ->
        Enum.chunk_every(prev_list, 2, 1, :discard)
        |> Enum.map(fn [a, b] -> b - a end)
      end)
      |> Enum.take_while(fn list -> Enum.any?(list, &(&1 != 0)) end)
      |> Enum.map(&List.first/1)
      |> Enum.reverse()
      |> Enum.reduce(0, fn i, acc -> i - acc end)
    end)
    |> Enum.sum()
  end
end

input = File.read!("./input/09.txt")

IO.puts(Day09.part1(input))
IO.puts(Day09.part2(input))
