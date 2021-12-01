pub fn solve() {
    let input: Vec<u64> = include_str!("./input/1.txt")
        .lines()
        .map(|line| line.parse().unwrap())
        .collect();

    // println!("{:?}", input);

    let mut part1: u64 = 0;
    let mut part2: u64 = 0;

    let mut prev: u64 = input[0];

    input.iter().for_each(|current| {
        if current > &prev {
            part1 += 1;
        }
        prev = *current;
    });

    prev = input[0] + input[1] + input[2];
    for i in 3..input.len() {
        let current = input[i] + input[i - 1] + input[i - 2];
        if current > prev {
            part2 += 1;
        }
        prev = current;
    }

    println!("part 1: {}", part1);
    println!("part 2: {}", part2);
}
