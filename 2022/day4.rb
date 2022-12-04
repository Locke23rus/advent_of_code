input = File.readlines('./input/4.txt', chomp: true)

pairs_of_ranges = input.map { |pair| pair.split(',').map { |range| Range.new(*range.split('-').map(&:to_i)) } }

part1 = pairs_of_ranges.count { |a, b| a.cover?(b) || b.cover?(a) }
part2 = pairs_of_ranges.count { |a, b| a.to_a.intersect?(b.to_a) }

puts part1, part2
