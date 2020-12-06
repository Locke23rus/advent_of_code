input = File.read("./input/6.txt")
groups = input.strip.split("\n\n")

part1 = groups.map { |group| group.tr("\n", "").chars.tally.keys.size }.sum
part2 = groups.map do |group|
  size = group.split("\n").size
  group.tr("\n", "").chars.tally.select { |k, v| v == size }.size
end.sum

puts "part1: #{part1}"
puts "part2: #{part2}"
