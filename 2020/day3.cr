input = File.read_lines("./input/3.txt")

def trees_counter(input, step_right, step_down)
  right = 0
  down = 0
  line_size = input[0].size
  map_multiplier = 1
  count = 0

  while down < input.size
    if right >= line_size * map_multiplier
      map_multiplier += 1
    end

    line = input[down] * map_multiplier
    count += 1 if line[right] == '#'

    # puts "right: #{right} down: #{down}"
    right += step_right
    down += step_down
  end

  count.to_u64
end

part1 = trees_counter(input, 3, 1)
puts "part1: #{part1}"

part2 = trees_counter(input, 1, 1) * part1 * trees_counter(input, 5, 1) * trees_counter(input, 7, 1) * trees_counter(input, 1, 2)
puts "part2: #{part2}"
