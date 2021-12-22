pub fn solve() {
    let input: Vec<u64> = include_str!("./input/1.txt")
        .lines()
        .map(|line| line.parse().unwrap())
        .collect();

    // println!("{:?}", input);

    let part1 = count_increments(input.clone());
    let part2: u64 = count_increments(
        input
            .windows(3)
            .map(|window| window.into_iter().sum())
            .collect::<Vec<u64>>(),
    );

    println!("part 1: {}", part1);
    println!("part 2: {}", part2);
}

fn count_increments(input: Vec<u64>) -> u64 {
    let mut result: u64 = 0;

    input.into_iter().reduce(|prev, current| {
        if current > prev {
            result += 1;
        }
        current
    });

    result
}
