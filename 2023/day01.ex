defmodule Day01 do
  @digits %{
    "one" => "1",
    "two" => "2",
    "three" => "3",
    "four" => "4",
    "five" => "5",
    "six" => "6",
    "seven" => "7",
    "eight" => "8",
    "nine" => "9"
  }

  def part1(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.replace(&1, ~r/\D/, ""))
    |> Enum.map(&String.to_integer(String.first(&1) <> String.last(&1)))
    |> Enum.sum()
  end

  def part2(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&scan_digits/1)
    |> Enum.map(&String.to_integer(Enum.at(&1, 0) <> Enum.at(&1, -1)))
    |> Enum.sum()
  end

  def scan_digits(str) do
    List.flatten(Regex.scan(~r/\d|one|two|three|four|five|six|seven|eight|nine/, str))
    |> Enum.map(&Map.get(@digits, &1, &1))
  end
end

input = File.read!("./input/01.txt")

IO.puts(Day01.part1(input))
IO.puts(Day01.part2(input))
