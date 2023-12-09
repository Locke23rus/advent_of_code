defmodule Day06 do
  def part1(input) do
    [times, distances] =
      input
      |> String.split("\n", trim: true)
      |> Enum.map(fn line ->
        Regex.scan(~r/\d+/, line)
        |> List.flatten()
        |> Enum.map(&String.to_integer/1)
      end)

    Enum.zip(times, distances)
    |> Enum.map(fn {t, d} ->
      0..t |> Enum.map(&((t - &1) * &1)) |> Enum.filter(&(&1 > d)) |> length()
    end)
    |> Enum.reduce(&Kernel.*/2)
  end

  def part2(input) do
    [time, distance] =
      input
      |> String.split("\n", trim: true)
      |> Enum.map(fn line ->
        Regex.scan(~r/\d+/, line)
        |> List.flatten()
        |> Enum.join()
        |> String.to_integer()
      end)

    0..time
    |> Enum.map(&((time - &1) * &1))
    |> Enum.count(&(&1 > distance))
  end
end

input = File.read!("./input/06.txt")

IO.puts(Day06.part1(input))
IO.puts(Day06.part2(input))
