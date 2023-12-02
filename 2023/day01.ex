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

  @words Enum.join(Map.keys(@digits), "|")
  @regex_first_digit ~r/\d|#{@words}/
  @regex_last_digit ~r/\d|#{String.reverse(@words)}/

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
    |> Enum.map(fn line ->
      first_digit = Regex.run(@regex_first_digit, line) |> List.first()

      last_digit =
        Regex.run(@regex_last_digit, String.reverse(line)) |> List.first() |> String.reverse()

      str = Map.get(@digits, first_digit, first_digit) <> Map.get(@digits, last_digit, last_digit)
      String.to_integer(str)
    end)
    |> Enum.sum()
  end
end

input = File.read!("./input/01.txt")

IO.puts(Day01.part1(input))
IO.puts(Day01.part2(input))
