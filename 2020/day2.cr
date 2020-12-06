input = File.read_lines("./input/2.txt")

part1 = input.reduce(0) do |acc, line|
  range, letter, password = line.split(" ")
  range = range.split('-').map { |i| i.to_i }
  range = Range.new(range[0], range[1])
  letter = letter[0]

  range.covers?(password.count(letter)) ? acc + 1 : acc
end

puts "part1: #{part1}"

part2 = input.reduce(0) do |acc, line|
  pos, letter, password = line.split(" ")
  pos = pos.split('-').map { |i| i.to_i }
  letter = letter[0]

  if password.size >= pos[1]
    a = password[pos[0] - 1] == letter
    b = password[pos[1] - 1] == letter
    acc += 1 if a != b && (a || b)
  end

  acc
end

puts "part2: #{part2}"
