input = File.readlines('./input/1.txt', chomp: true)

sums = input.slice_before(&:empty?).map { |group| group.map(&:to_i).sum }
part1 = sums.max
part2 = sums.max(3).sum
puts part1, part2
