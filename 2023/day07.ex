defmodule Day07 do
  def part1(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      [hand, bid] = String.split(line, " ")
      {String.graphemes(hand), String.to_integer(bid)}
    end)
    |> Enum.sort(fn {a, _}, {b, _} -> compare_hands_v1(a, b) end)
    |> Enum.with_index(1)
    |> Enum.map(fn {{_, bid}, index} -> bid * index end)
    |> Enum.sum()
  end

  def part2(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      [hand, bid] = String.split(line, " ")
      {String.graphemes(hand), String.to_integer(bid)}
    end)
    |> Enum.sort(fn {a, _}, {b, _} -> compare_hands_v2(a, b) end)
    |> Enum.with_index(1)
    |> Enum.map(fn {{_, bid}, index} -> bid * index end)
    |> Enum.sum()
  end

  def compare_hands_v1(hand1, hand2) do
    score1 = hand_score_v1(hand1)
    score2 = hand_score_v1(hand2)

    if score1 == score2 do
      {a, b} = Enum.zip(hand1, hand2) |> Enum.filter(fn {a, b} -> a != b end) |> List.first()
      card_score_v1(a) < card_score_v1(b)
    else
      score1 < score2
    end
  end

  def compare_hands_v2(hand1, hand2) do
    score1 = hand_score_v2(hand1)
    score2 = hand_score_v2(hand2)

    if score1 == score2 do
      {a, b} = Enum.zip(hand1, hand2) |> Enum.filter(fn {a, b} -> a != b end) |> List.first()
      card_score_v2(a) < card_score_v2(b)
    else
      score1 < score2
    end
  end

  def hand_score_v1(hand) do
    tally =
      hand
      |> Enum.group_by(& &1)
      |> Enum.map(fn {_, v} -> Enum.count(v) end)
      |> Enum.sort()

    case tally do
      [5] -> 6
      [1, 4] -> 5
      [2, 3] -> 4
      [1, 1, 3] -> 3
      [1, 2, 2] -> 2
      [1, 1, 1, 2] -> 1
      _ -> 0
    end
  end

  def hand_score_v2(hand) do
    tally =
      hand
      |> Enum.filter(&(&1 != "J"))
      |> Enum.group_by(& &1)
      |> Enum.map(fn {_, v} -> Enum.count(v) end)
      |> Enum.sort()

    case tally do
      [5] -> 7
      [4] -> 6
      [3] -> 6
      [2] -> 6
      [1] -> 6
      [] -> 6
      [1, 4] -> 5
      [1, 3] -> 5
      [1, 2] -> 5
      [2, 3] -> 4
      [2, 2] -> 4
      [1, 1, 3] -> 3
      [1, 1, 2] -> 3
      [1, 1, 1] -> 3
      [1, 2, 2] -> 2
      [1, 1, 1, 2] -> 1
      [1, 1, 1, 1] -> 1
      _ -> 0
    end
  end

  def card_score_v1(char) do
    {index, _} = :binary.match("23456789TJQKA", char)
    index
  end

  def card_score_v2(char) do
    {index, _} = :binary.match("J23456789TQKA", char)
    index
  end
end

input = File.read!("./input/07.txt")

IO.puts(Day07.part1(input))
IO.puts(Day07.part2(input))
