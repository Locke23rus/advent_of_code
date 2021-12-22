pub fn solve() {
    let input: Vec<isize> = include_str!("./input/7.txt")
        .split(',')
        .map(|s| s.parse().unwrap())
        .collect();

    // println!("{:?}", input);

    let max = input.clone().into_iter().max().unwrap();
    let part1: isize = (0..max)
        .into_iter()
        .map(|i| input.clone().into_iter().map(|j| (i - j).abs()).sum())
        .min()
        .unwrap();
    let part2: isize = (0..max)
        .into_iter()
        .map(|i| {
            input
                .clone()
                .into_iter()
                .map(|j: isize| {
                    let n = (i - j).abs();
                    n * (n + 1) / 2
                })
                .sum()
        })
        .min()
        .unwrap();

    println!("part 1: {}", part1);
    println!("part 2: {}", part2);
}
