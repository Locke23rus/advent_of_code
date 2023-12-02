defmodule Day02 do
  def part1(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_games/1)
    |> Enum.filter(&valid_game?/1)
    |> Enum.map(&elem(&1, 0))
    |> Enum.sum()
  end

  def part2(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_games/1)
    |> Enum.map(fn {_, subsets} ->
      red = subsets |> Enum.map(&Map.get(&1, "red", 0)) |> Enum.max()
      green = subsets |> Enum.map(&Map.get(&1, "green", 0)) |> Enum.max()
      blue = subsets |> Enum.map(&Map.get(&1, "blue", 0)) |> Enum.max()

      red * green * blue
    end)
    |> Enum.sum()
  end

  def valid_game?(game) do
    {_, subsets} = game

    Enum.all?(subsets, fn cubes ->
      Map.get(cubes, "red", 0) <= 12 &&
        Map.get(cubes, "green", 0) <= 13 &&
        Map.get(cubes, "blue", 0) <= 14
    end)
  end

  def parse_games(str) do
    [game, subsets] = str |> String.split(":")
    {parse_game_id(game), parse_subsets(subsets)}
  end

  def parse_game_id(str) do
    String.slice(str, 5..-1) |> String.to_integer()
  end

  def parse_subsets(str) do
    str
    |> String.split(";")
    |> Enum.map(&String.trim/1)
    |> Enum.map(fn str ->
      cubes = str |> String.split(",") |> Enum.map(&parse_cube/1)
      Map.new(cubes)
    end)
  end

  def parse_cube(str) do
    [count, color] = str |> String.trim() |> String.split(" ")
    {color, String.to_integer(count)}
  end
end

input = File.read!("./input/02.txt")

IO.puts(Day02.part1(input))
IO.puts(Day02.part2(input))
