defmodule Day03 do
  def part1(input) do
    lines = String.split(input, "\n", trim: true)
    max_y = length(lines)

    lines
    |> Enum.with_index()
    |> Enum.map(fn {line, y} ->
      number_slices = Regex.scan(~r/\d+/, line, return: :index) |> List.flatten()

      number_slices
      |> Enum.map(fn {start, len} ->
        area_x = if start > 0, do: start - 1, else: 0
        area_length = if start > 0, do: len + 2, else: len + 1
        area_y = if y > 0, do: y - 1, else: 0
        area_height = if y == 0 || y == max_y, do: 2, else: 3

        adjusted? =
          Enum.slice(lines, area_y, area_height)
          |> Enum.map(&String.slice(&1, area_x, area_length))
          |> Enum.join("")
          |> String.match?(~r/[^.0-9]/)

        str = String.slice(line, start, len)

        if adjusted?, do: String.to_integer(str), else: 0
      end)
    end)
    |> List.flatten()
    |> Enum.sum()
  end

  def part2(input) do
    input
    |> String.split("\n", trim: true)
    |> String.length()
  end
end

input = File.read!("./input/03.txt")

IO.puts(Day03.part1(input))
# IO.puts(Day02.part2(input))
