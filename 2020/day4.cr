input = File.read("./input/4.txt")

required_keys = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]
passports = input.strip.split("\n\n")

part1 = passports.reduce(0) do |acc, pass|
  keys = pass.tr("\n", " ").split(" ").map { |pair| pair.split(":")[0] }
  (keys & required_keys).size == required_keys.size ? acc + 1 : acc
end

puts "part1: #{part1}"

key_rules = {
  byr: ->(x : String) { x.matches?(/^\d{4}$/) && (1900..2002).includes?(x.to_i) },
  iyr: ->(x : String) { x.matches?(/^\d{4}$/) && (2010..2020).includes?(x.to_i) },
  eyr: ->(x : String) { x.matches?(/^\d{4}$/) && (2020..2030).includes?(x.to_i) },
  hgt: ->(x : String) { x.matches?(/^(\d{3}cm)|(\d{2}in)$/) && (x.includes?("cm") ? (150..193).includes?(x[0..2].to_i) : (59..76).includes?(x[0..1].to_i)) },
  hcl: ->(x : String) { x.matches?(/^#[0-9a-f]{6}$/) },
  ecl: ->(x : String) { x.matches?(/^(amb|blu|brn|gry|grn|hzl|oth)$/) },
  pid: ->(x : String) { x.matches?(/^\d{9}$/) },
  cid: ->(x : String) { true },
}

part2 = passports.reduce(0) do |acc, str|
  pass = str.tr("\n", " ").split(" ").map { |pair| pair.split(":") }.to_h
  b = (pass.keys & required_keys).size == required_keys.size && pass.all? { |k, v| key_rules[k].call(v) } ? acc + 1 : acc
end

puts "part2: #{part2}"
