pub fn solve() {
    let input: Vec<&str> = include_str!("./input/3.txt").lines().collect();

    let len = input[0].len();
    let mut gamma_rate: i64 = 0;
    let mut epsilon_rate: i64 = 0;
    let oxygen_generator_rating: i64 = find_rating(input.clone(), (1, 0));
    let co2_scrubber_rating: i64 = find_rating(input.clone(), (0, 1));

    for i in 0..len {
        gamma_rate = (gamma_rate << 1) + find_most_common_bit(input.clone(), i);
        epsilon_rate = (epsilon_rate << 1) + find_least_common_bit(input.clone(), i);
    }

    println!("part 1: {}", gamma_rate * epsilon_rate);
    println!("part 2: {}", oxygen_generator_rating * co2_scrubber_rating);
}

fn find_rating(input: Vec<&str>, criteria: (i64, i64)) -> i64 {
    let mut lines: Vec<&str> = input.clone();
    for i in 0..input[0].len() {
        if lines.len() == 1 {
            return i64::from_str_radix(lines[0], 2).unwrap();
        }
        let bit = find_common_bit(lines.clone(), i, criteria);
        lines = lines
            .into_iter()
            .filter(|l| l.chars().nth(i).unwrap().to_string() == bit.to_string())
            .collect();
    }
    return i64::from_str_radix(lines[0], 2).unwrap();
}

fn find_most_common_bit(input: Vec<&str>, i: usize) -> i64 {
    find_common_bit(input, i, (1, 0))
}

fn find_least_common_bit(input: Vec<&str>, i: usize) -> i64 {
    find_common_bit(input, i, (0, 1))
}

fn find_common_bit(input: Vec<&str>, i: usize, criteria: (i64, i64)) -> i64 {
    let bit: i64 = input.into_iter().fold(0, |sum, n| {
        if n.chars().nth(i).unwrap() == '1' {
            sum + 1
        } else {
            sum - 1
        }
    });

    if bit >= 0 {
        criteria.0
    } else {
        criteria.1
    }
}
