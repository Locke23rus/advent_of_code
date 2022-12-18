input = File.read('./input/5.txt')

config, moves = input.split("\n\n")
stacks1 = config.split("\n").reverse.map(&:chars).transpose.filter_map do |stack|
  stack.reject { |crate| crate == ' ' } if stack.shift.to_i.positive?
end
stacks2 = stacks1.map(&:dup)

MOVE_REGEXP = /move (\d+) from (\d+) to (\d+)/

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
