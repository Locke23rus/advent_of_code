numbers = File.read_lines("./input/1.txt").map { |n| n.to_i }

numbers.each do |a|
  numbers.each do |b|
    puts a * b if a + b == 2020
    numbers.each do |c|
      puts a * b * c if a + b + c == 2020
    end
  end
end
