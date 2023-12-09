defmodule Day07 do
  @cards_scores "23456789TJQKA"
  def part1(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      [hand, bid] = String.split(line, " ")
      {String.graphemes(hand), String.to_integer(bid)}
    end)
    |> Enum.sort(fn {a, _}, {b, _} ->
      aa = hand_score(a)
      bb = hand_score(b)
      aa < bb || (aa == bb && compare_hands(a, b))
    end)
    |> Enum.with_index(1)
    |> Enum.map(fn {{_, bid}, index} -> bid * index end)
    |> Enum.sum()
  end

  def part2(input) do
    input |> String.split("\n", trim: true) |> IO.inspect()

    0
  end

  def compare_hands(hand1, hand2) do
    if hand1 == hand2 do
      true
    else
      [{a, b} | _] = Enum.zip(hand1, hand2) |> Enum.filter(fn {a, b} -> a != b end)
      card_score(a) < card_score(b)
    end
  end

  def hand_score(hand) do
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

  # def hand_score({a, a, a, a, a}), do: 6
  # def hand_score({a, a, b, a, a}), do: 5
  # def hand_score({a, b, b, b, a}), do: 4
  # def hand_score({a, a, a, b, c}), do: 3
  # def hand_score({a, b, c, b, a}), do: 2
  # def hand_score({a, b, c, a, d}), do: 1
  # def hand_score({a, b, c, d, e}), do: 0

  def card_score(char) do
    {index, _} = :binary.match(@cards_scores, char)
    index
  end
end

input = File.read!("./input/07.txt")

IO.puts(Day07.part1(input))
# IO.puts(Day07.part2(input))
