defmodule Day10 do
  def part1(input) do
    lines = String.split(input, "\n", trim: true)
    map = build_map(lines)
    max_y = length(lines) - 1
    max_x = div(map_size(map), max_y + 1) - 1
    start_point = map |> Map.to_list() |> Enum.find(fn {_, v} -> v == "S" end) |> elem(0)
    next_step = find_next_step(map, start_point, max_x, max_y)
    loop = build_loop(map, start_point, next_step)

    div(length(loop), 2) + 1
  end

  def part2(input) do
    lines = String.split(input, "\n", trim: true)
    map = build_map(lines)
    max_y = length(lines) - 1
    max_x = div(map_size(map), max_y + 1) - 1
    start_point = map |> Map.to_list() |> Enum.find(fn {_, v} -> v == "S" end) |> elem(0)
    next_step = find_next_step(map, start_point, max_x, max_y)
    loop = [start_point | build_loop(map, start_point, next_step)] |> MapSet.new()

    points = Map.keys(map) |> MapSet.new()
    non_loop_points = MapSet.difference(points, loop)
    groups = group_points(non_loop_points)

    groups
    |> Enum.map(fn points ->
      {points, get_enclosing_points(points, max_x, max_y)}
    end)
    |> Enum.filter(fn {points, enclosing_points} ->
      points
      |> Enum.all?(fn {x, y} -> x > 0 && y > 0 && x < max_x && y < max_y end) &&
        MapSet.subset?(enclosing_points, loop)
    end)
    |> Enum.map(fn {points, _} ->
      points |> Enum.count(&(Map.get(map, &1) == "."))
    end)
    |> Enum.sum()
  end

  def get_enclosing_points(points, max_x, max_y) do
    set = MapSet.new(points)

    points
    |> Enum.map(&get_neighbors(&1, max_x, max_y))
    |> List.flatten()
    |> MapSet.new()
    |> MapSet.difference(set)
  end

  def get_neighbors({x, y}, max_x, max_y) do
    [
      {x - 1, y - 1},
      {x - 1, y},
      {x - 1, y + 1},
      {x, y - 1},
      {x, y + 1},
      {x + 1, y - 1},
      {x + 1, y},
      {x + 1, y + 1}
    ]
    |> Enum.filter(fn {x, y} -> x >= 0 && x <= max_x && y >= 0 && y <= max_y end)
  end

  def group_points(points) do
    Stream.iterate({Enum.map(points, &[&1]), 0}, fn {prev_groups, _} ->
      next_groups =
        prev_groups
        |> Enum.reduce([], fn group, acc ->
          index = acc |> Enum.find_index(fn g -> connected_groups?(group, g) end)

          case index do
            nil ->
              acc ++ [group]

            _ ->
              List.update_at(acc, index, &(&1 ++ group))
          end
        end)

      {next_groups, length(prev_groups)}
    end)
    |> Enum.find(fn {groups, count} -> count == length(groups) end)
    |> elem(0)
  end

  def connected_groups?(group1, group2) do
    group1 |> Enum.any?(fn point -> Enum.any?(group2, &connected_points?(point, &1)) end)
  end

  def connected_points?({x1, y1}, {x2, y2}) do
    (x1 == x2 && abs(y1 - y2) == 1) ||
      (y1 == y2 && abs(x1 - x2) == 1)
  end

  def build_map(lines) do
    lines
    |> Enum.with_index()
    |> Enum.flat_map(fn {line, y} ->
      line
      |> String.graphemes()
      |> Enum.with_index()
      |> Enum.map(fn {char, x} -> {{x, y}, char} end)
    end)
    |> Map.new()
  end

  def build_loop(map, start_point, next_step) do
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
      point !== start_point
    end)
    |> Enum.map(&elem(&1, 1))
  end

  def find_next_step(map, start, max_x, max_y) do
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
