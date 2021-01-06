pub fn solve() {
    let data: Vec<u64> = include_str!("./input/1.txt")
        .lines()
        .map(|line| line.parse().unwrap())
        .collect();

    // println!("{:?}", data);

    let mut part1: u64 = 0;
    let mut part2: u64 = 0;

    data.iter().for_each(|a| {
        data.iter().for_each(|b| {
            if a + b == 2020 {
                part1 = a * b
            }
            data.iter().for_each(|c| {
                if a + b + c == 2020 {
                    part2 = a * b * c
                }
            });
        });
    });
    // let part2: u64 = data
    //     .iter()
    //     .map(|mass| total_fuel(*mass))
    //     .fold(0, |sum, i| sum + i);

    println!("part 1: {}", part1);
    println!("part 2: {}", part2);
}
