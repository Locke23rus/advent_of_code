pub fn solve() {
    let lines: Vec<&str> = include_str!("./input/2.txt").lines().collect();
    // println!("{:?}", lines);

    let part1: u64 = lines.iter().fold(0, |sum, _i| sum + 1);
    // let mut part2: u64 = 0;

    println!("part 1: {}", part1);
    // println!("part 2: {}", part2);
}
