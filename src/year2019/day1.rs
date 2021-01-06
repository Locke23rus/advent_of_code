fn mass_to_fuel(mass: u64) -> u64 {
    (mass / 3).saturating_sub(2)
}

fn total_fuel(mass: u64) -> u64 {
    if mass <= 0 {
        0
    } else {
        let x = mass_to_fuel(mass);
        x + total_fuel(x)
    }
}

pub fn solve() {
    let data: Vec<u64> = include_str!("./input/day1.txt")
        .lines()
        .map(|line| line.parse().unwrap())
        .collect();

    // println!("{:?}", data);

    let part1: u64 = data
        .iter()
        .map(|mass| mass_to_fuel(*mass))
        .fold(0, |sum, i| sum + i);
    let part2: u64 = data
        .iter()
        .map(|mass| total_fuel(*mass))
        .fold(0, |sum, i| sum + i);

    println!("part 1: {}", part1);
    println!("part 2: {}", part2);
}
