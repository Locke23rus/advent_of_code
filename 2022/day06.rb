input = File.read('./input/06.txt').chomp

i = 3
i += 1 while i < input.size - 1 && input[i - 3..i].chars.uniq.size < 4

j = 13
j += 1 while j < input.size - 1 && input[j - 13..j].chars.uniq.size < 14

part1 = i + 1
part2 = j + 1

puts part1, part2
