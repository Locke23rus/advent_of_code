input = File.read('./input/5.txt')

config, moves = input.split("\n\n")
config = config.split("\n").reverse
stacks_count = config.first.split(' ').last.to_i
stacks1 = Array.new(stacks_count) { |_| [] }

config[1..].each do |line|
  stacks_count.times do |i|
    crate = line[1 + i * 4]
    stacks1[i] << crate if crate != ' '
  end
end

stacks2 = stacks1.map(&:dup)

MOVE_REGEXP = /move (\d+) from (\d+) to (\d+)/.freeze

moves.split("\n").each do |move|
  amount, from, to = MOVE_REGEXP.match(move).captures.map(&:to_i)

  amount.times do
    stacks1[to - 1] << stacks1[from - 1].pop
  end

  stacks2[to - 1].concat stacks2[from - 1].pop(amount)
end

part1 = stacks1.map(&:last).join
part2 = stacks2.map(&:last).join

puts part1, part2
