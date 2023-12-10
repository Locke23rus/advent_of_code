defmodule Day10 do
  def part1(input) do
    lines =
      input
      |> String.split("\n", trim: true)

    map =
      lines
      |> Enum.with_index()
      |> Enum.reduce(%{}, fn {line, y}, acc ->
        line
        |> String.graphemes()
        |> Enum.with_index()
        |> Enum.reduce(acc, fn {char, x}, acc ->
          Map.put(acc, {x, y}, char)
        end)
      end)

    max_y = length(lines) - 1
    max_x = div(map_size(map), length(lines)) - 1
    start = map |> Map.to_list() |> Enum.find(fn {_, v} -> v == "S" end) |> elem(0)

    next_step =
      [
        {:up, {elem(start, 0), elem(start, 1) - 1}},
        {:down, {elem(start, 0), elem(start, 1) + 1}},
        {:left, {elem(start, 0) - 1, elem(start, 1)}},
        {:right, {elem(start, 0) + 1, elem(start, 1)}}
      ]
      |> Enum.find(fn {direction, {x, y}} ->
        x >= 0 && x <= max_x && y >= 0 && y <= max_y &&
          valid_tile?(direction, map |> Map.get({x, y}))
      end)

    loop =
      Stream.iterate(next_step, fn {from_dir, {x, y}} ->
        tile = Map.get(map, {x, y})
        to_dir = next_direction(from_dir, tile)

        case to_dir do
          :up -> {to_dir, {x, y - 1}}
          :down -> {to_dir, {x, y + 1}}
          :left -> {to_dir, {x - 1, y}}
          :right -> {to_dir, {x + 1, y}}
        end
      end)
      |> Enum.take_while(fn {_, point} ->
        start !== point
      end)

    div(length(loop), 2) + 1
  end

  def part2(input) do
    input
    |> String.split("\n", trim: true)

    0
  end

  def valid_tile?(direction, tile) do
    case direction do
      :up -> String.contains?("F|7", tile)
      :down -> String.contains?("L|J", tile)
      :left -> String.contains?("F-L", tile)
      :right -> String.contains?("J-7", tile)
    end
  end

  def next_direction(dir, tile) do
    case {dir, tile} do
      {:up, "|"} -> :up
      {:up, "F"} -> :right
      {:up, "7"} -> :left
      {:down, "|"} -> :down
      {:down, "L"} -> :right
      {:down, "J"} -> :left
      {:left, "-"} -> :left
      {:left, "F"} -> :down
      {:left, "L"} -> :up
      {:right, "-"} -> :right
      {:right, "7"} -> :down
      {:right, "J"} -> :up
    end
  end
end

input = File.read!("./input/10.txt")

IO.puts(Day10.part1(input))
IO.puts(Day10.part2(input))
