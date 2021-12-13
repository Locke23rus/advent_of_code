pub fn solve() {
    let input: Vec<&str> = include_str!("./input/8.txt").lines().collect();

    // println!("{:?}", input);

    let output_digits: Vec<&str> = input
        .clone()
        .into_iter()
        .flat_map(|s| s.split_once(" | ").unwrap().1.split(' ').collect::<Vec<&str>>())
        .collect();

    let part1 = output_digits.into_iter().fold(0, |sum, s| {
        if s.len() == 2 || s.len() == 3 || s.len() == 4 || s.len() == 7 {
            sum + 1
        } else {
            sum
        }
    });

    let part2 = input.clone().into_iter().fold(0, |sum, line| sum + parse_digits(line));

    println!("part 1: {}", part1);
    println!("part 2: {}", part2);
}

fn parse_digits(line: &str) -> usize {
    let pair = line.split_once(" | ").unwrap();
    let mut pew: Vec<Vec<&str>> = vec![vec![]; 10];
    let patterns: Vec<Vec<&str>> = pair
        .0
        .split(' ')
        .map(|s| s.split("").filter(|s| s.len() == 1).collect())
        .collect();
    let digits: Vec<Vec<&str>> = pair
        .1
        .split(' ')
        .map(|s| s.trim().split("").filter(|s| s.len() == 1).collect())
        .collect();

    pew[1] = patterns.clone().into_iter().find(|p| p.len() == 2).unwrap();
    pew[4] = patterns.clone().into_iter().find(|p| p.len() == 4).unwrap();
    pew[7] = patterns.clone().into_iter().find(|p| p.len() == 3).unwrap();
    pew[8] = patterns.clone().into_iter().find(|p| p.len() == 7).unwrap();

    let mut len6: Vec<Vec<&str>> = patterns.clone().into_iter().filter(|p| p.len() == 6).collect();
    let (yep, nope): (Vec<Vec<&str>>, Vec<Vec<&str>>) = len6
        .clone()
        .into_iter()
        .partition(|p| pew[4].iter().all(|letter| p.contains(letter)));
    pew[9] = yep.first().unwrap().to_owned();
    len6 = nope;

    let (yep, nope): (Vec<Vec<&str>>, Vec<Vec<&str>>) = len6
        .clone()
        .into_iter()
        .partition(|p| pew[1].iter().all(|letter| p.contains(letter)));
    pew[0] = yep.first().unwrap().to_owned();
    pew[6] = nope.first().unwrap().to_owned();

    let mut len5: Vec<Vec<&str>> = patterns.clone().into_iter().filter(|p| p.len() == 5).collect();
    let (yep, nope): (Vec<Vec<&str>>, Vec<Vec<&str>>) = len5
        .clone()
        .into_iter()
        .partition(|p| pew[1].iter().all(|letter| p.contains(letter)));
    pew[3] = yep.first().unwrap().to_owned();
    len5 = nope;

    let (yep, nope): (Vec<Vec<&str>>, Vec<Vec<&str>>) = len5
        .clone()
        .into_iter()
        .partition(|p| p.iter().all(|letter| pew[6].contains(letter)));
    pew[5] = yep.first().unwrap().to_owned();
    pew[2] = nope.first().unwrap().to_owned();

    digits
        .into_iter()
        .fold("".to_string(), |sum, digit| {
            let n = pew
                .clone()
                .into_iter()
                .position(|p| p.len() == digit.len() && digit.iter().all(|c| p.contains(c)))
                .unwrap();

            format!("{}{}", sum, n)
        })
        .parse()
        .unwrap()
}
