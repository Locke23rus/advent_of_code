input = File.readlines('./input/3.txt', chomp: true)

priorities = ('a'..'z').to_a + ('A'..'Z').to_a

part1 = input.map(&:chars).flat_map do |pack|
  half1 = pack[0...(pack.size / 2)]
  half2 = pack[(pack.size / 2)..]
  common_chars = half1.intersection(half2)
  common_chars.map { |char| priorities.index(char) + 1 }
end.sum

part2 = input.map(&:chars).each_slice(3).flat_map do |group|
  common_chars = group[0].intersection(group[1]).intersection(group[2])
  common_chars.map { |char| priorities.index(char) + 1 }
end.sum

puts part1, part2
