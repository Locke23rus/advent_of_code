input = File.readlines('./input/3.txt', chomp: true)

priorities = ('a'..'z').to_a + ('A'..'Z').to_a

part1 = input.map(&:chars).flat_map do |pack|
  half1 = pack[0...(pack.size / 2)]
  half2 = pack[(pack.size / 2)..]
  (half1 & half2).map { |char| priorities.index(char) + 1 }
end.sum

part2 = input.map(&:chars).each_slice(3).flat_map do |group|
  (group[0] & group[1] & group[2]).map { |char| priorities.index(char) + 1 }
end.sum

puts part1, part2
