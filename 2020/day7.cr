input = File.read_lines("./input/7.txt")
bags = {} of String => Hash(String, Int32)

input.each do |line|
  color, content = line.split(" bags contain ")
  bags[color] = {} of String => Int32
  next if content.includes?("no other bags")
  content.split(", ").each do |bag_info|
    parts = bag_info.split(" ")
    amount = parts[0].to_i
    nested_color = parts[1..2].join(" ")
    bags[color][nested_color] = amount
  end
end

def bag_includes?(bags, color)
  nested_bags = bags[color]
  nested_bags.keys.includes?("shiny gold") || nested_bags.keys.any? { |nested_color| bag_includes?(bags, nested_color) }
end

part1 = bags.keys.reduce(0) { |acc, color| bag_includes?(bags, color) ? acc + 1 : acc }
puts "part1: #{part1}"

def count_nested_bags(bags, color)
  nested_bags = bags[color]
  1 + nested_bags.map { |nested_color, amount| count_nested_bags(bags, nested_color).as(Int32) * amount }.sum
end

part2 = count_nested_bags(bags, "shiny gold") - 1

puts "part2: #{part2}"
