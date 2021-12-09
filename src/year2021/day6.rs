pub fn solve() {
    let input: Vec<usize> = include_str!("./input/6.txt")
        .split(',')
        .map(|line| line.parse().unwrap())
        .collect();

    // println!("{:?}", input);

    let aggregated_input: [usize; 9] = input.into_iter().fold([0; 9], |mut sum, i| {
        sum[i] += 1;
        sum
    });

    let mut part1: usize = 0;
    let mut part2: usize = 0;

    for i in 0..9 {
        let count = aggregated_input[i];
        if count > 0 {
            part1 += count * simulate(i, 80);
            part2 += count * simulate(i, 256);
        }
    }

    println!("part 1: {}", part1);
    println!("part 2: {}", part2);
}

fn simulate(n: usize, days: usize) -> usize {
    let mut state: [usize; 9] = [0; 9];
    state[n] = 1;
    (0..days).for_each(|_day| {
        let mut new_state: [usize; 9] = [0; 9];
        for i in (0..=8).rev() {
            let count = state[i];
            if count > 0 {
                if i > 0 {
                    new_state[i - 1] = count;
                } else {
                    new_state[6] += count;
                    new_state[8] = count;
                }
            }
        }
        state = new_state;
    });
    state.iter().sum()
}
