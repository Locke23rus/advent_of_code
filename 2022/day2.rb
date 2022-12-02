input = File.readlines('./input/2.txt', chomp: true)

scores1 = {
  'A X' => 4,
  'A Y' => 8,
  'A Z' => 3,
  'B X' => 1,
  'B Y' => 5,
  'B Z' => 9,
  'C X' => 7,
  'C Y' => 2,
  'C Z' => 6
}

scores2 = {
  'A X' => 3,
  'A Y' => 4,
  'A Z' => 8,
  'B X' => 1,
  'B Y' => 5,
  'B Z' => 9,
  'C X' => 2,
  'C Y' => 6,
  'C Z' => 7
}

part1 = input.map { |round| scores1[round] }.sum
part2 = input.map { |round| scores2[round] }.sum

puts part1, part2
