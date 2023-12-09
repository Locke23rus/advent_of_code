defmodule Day08 do
  def part1(input) do
    [seq | lines] = input |> String.split("\n", trim: true)

    seq = seq |> String.graphemes()
    seq_size = length(seq)

    map =
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

    {_, iterations} =
      Stream.iterate({"AAA", 0}, fn {prev_key, i} ->
        {left, right} = Map.get(map, prev_key)
        side = Enum.at(seq, rem(i, seq_size))
        next_key = if side == "L", do: left, else: right
        {next_key, i + 1}
      end)
      |> Enum.take_while(fn {key, _} -> key != "ZZZ" end)
      |> List.last()

    iterations + 1
  end

  def part2(input) do
    input
    |> String.split("\n", trim: true)
    |> length()
  end
end

input = File.read!("./input/08.txt")

IO.puts(Day08.part1(input))
IO.puts(Day08.part2(input))
