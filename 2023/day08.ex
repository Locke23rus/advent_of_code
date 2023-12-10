require Math

defmodule Day08 do
  def part1(input) do
    [seq | lines] = input |> String.split("\n", trim: true)
    seq = seq |> String.graphemes()
    map = parse_nodes(lines)

    nodes_stream(seq, map, "AAA")
    |> Enum.find(fn {key, _} -> key == "ZZZ" end)
    |> elem(1)
  end

  def part2(input) do
    [seq | lines] = input |> String.split("\n", trim: true)
    seq = seq |> String.graphemes()
    map = parse_nodes(lines)

    Map.keys(map)
    |> Enum.filter(&String.ends_with?(&1, "A"))
    |> Enum.map(fn starting_key ->
      nodes_stream(seq, map, starting_key)
      |> Enum.find(fn {key, _} -> String.ends_with?(key, "Z") end)
      |> elem(1)
    end)
    |> Enum.reduce(&Math.lcm/2)
  end

  def parse_nodes(lines) do
    lines
    |> Enum.map(fn line ->
      node = String.slice(line, 0, 3)
      left = String.slice(line, 7, 3)
      right = String.slice(line, 12, 3)
      {node, left, right}
    end)
    |> Enum.reduce(%{}, fn {node, left, right}, acc ->
      Map.put(acc, node, {left, right})
    end)
  end

  def nodes_stream(seq, map, starting_key) do
    seq_size = length(seq)

    Stream.iterate({starting_key, 0}, fn {prev_key, i} ->
      {left, right} = Map.get(map, prev_key)
      side = Enum.at(seq, rem(i, seq_size))
      next_key = if side == "L", do: left, else: right
      {next_key, i + 1}
    end)
  end
end

input = File.read!("./input/08.txt")

IO.puts(Day08.part1(input))
IO.puts(Day08.part2(input))
