use std::collections::BTreeMap;

pub fn solve() {
    let input: Vec<(&str, &str)> = include_str!("./input/12.txt")
        .lines()
        .map(|line| line.split_once('-').unwrap())
        .collect();

    println!("{:?}", input);

    let mut map: BTreeMap<&str, Vec<&str>> = BTreeMap::new();

    input.into_iter().for_each(|(a, b)| {
        match map.get(a) {
            Some(mut v) => {
                v.push(b);
            }
            None => {
                map.insert(a, vec![b]);
            }
        }

        // if map.contains_key(a) {
        //     map[a].push(b);
        // } else {
        //     map.insert(a, vec![b]);
        // }
    });

    let part1: usize = 0;
    let part2: usize = 0;

    println!("part 1: {}", part1);
    println!("part 2: {}", part2);
}
