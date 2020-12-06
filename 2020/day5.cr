input = File.read_lines("./input/5.txt")

def finder(seat, lower_char, lower, upper)
  step = (upper - lower + 1) / 2
  if seat[0] == lower_char
    seat.size == 1 ? lower : finder(seat[1..-1], lower_char, lower, upper - step)
  else
    seat.size == 1 ? upper : finder(seat[1..-1], lower_char, lower + step, upper)
  end
end

def get_seat_id(seat)
  row = finder(seat[0..7], 'F', 0, 127)
  column = finder(seat[7..-1], 'L', 0, 7)
  (row * 8 + column).to_i
end

def free_seat_finder(seat_ids)
  sorted = seat_ids.sort
  sorted.each_with_index do |seat_id, i|
    next if i == 0
    prev_seat_id = sorted[i - 1]
    return seat_id - 1 if (seat_id - prev_seat_id == 2) || (seat_id - prev_seat_id == 9)
  end
  0
end

seat_ids = input.map { |seat| get_seat_id(seat) }
part1 = seat_ids.max
part2 = free_seat_finder(seat_ids)

puts "part1: #{part1}"
puts "part2: #{part2}"
