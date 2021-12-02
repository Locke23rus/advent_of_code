pub fn solve() {
    let input = include_str!("./input/2.txt").lines();
    let commands: Vec<(&str, u64)> = input
        .map(|line| line.split_once(' ').unwrap())
        .map(|cmd| (cmd.0, cmd.1.parse().unwrap()))
        .collect();

    // println!("{:?}", input);

    let mut x1 = 0;
    let mut y1 = 0;

    commands.iter().for_each(|cmd| match cmd {
        ("forward", i) => x1 += i,
        ("down", i) => y1 += i,
        ("up", i) => y1 -= i,
        _ => {}
    });

    let mut x2 = 0;
    let mut y2 = 0;
    let mut aim: u64 = 0;
    commands.iter().for_each(|cmd| match cmd {
        ("forward", i) => {
            x2 += i;
            y2 += aim * i;
        }
        ("down", i) => aim += i,
        ("up", i) => aim -= i,
        _ => {}
    });

    println!("part 1: {}", x1 * y1);
    println!("part 2: {}", x2 * y2);
}
