use std::collections::HashSet;

pub fn solve() {
    let input: Vec<Vec<usize>> = include_str!("./input/9.txt")
        .lines()
        .map(|line| line.chars().map(|n| n.to_string().parse().unwrap()).collect())
        .collect();

    // println!("{:?}", input);

    let max_y = input.len();
    let max_x = input[0].len();

    let mut lowest_points: Vec<(usize, usize)> = vec![];

    for y in 0..max_y {
        for x in 0..max_x {
            if find_peers((x, y), max_x, max_y)
                .into_iter()
                .all(|(x2, y2)| input[y][x] < input[y2][x2])
            {
                lowest_points.push((x, y));
            }
        }
    }

    let part1: usize = lowest_points
        .clone()
        .into_iter()
        .fold(0, |sum, (x, y)| sum + input[y][x] + 1);
    let mut basin_sizes: Vec<usize> = lowest_points
        .into_iter()
        .map(|point: (usize, usize)| find_basin(input.clone(), point).len())
        .collect();

    basin_sizes.sort();
    basin_sizes.reverse();

    // println!("basin_sizes: {:?}", basin_sizes);

    let part2: usize = basin_sizes.into_iter().take(3).fold(1, |sum, n| sum * n);

    println!("part 1: {}", part1);
    println!("part 2: {}", part2);
}

fn find_peers((x, y): (usize, usize), max_x: usize, max_y: usize) -> Vec<(usize, usize)> {
    let mut peers: Vec<(usize, usize)> = vec![];

    if y > 0 {
        peers.push((x, y - 1));
    }
    if y < max_y - 1 {
        peers.push((x, y + 1));
    }
    if x > 0 {
        peers.push((x - 1, y));
    }
    if x < max_x - 1 {
        peers.push((x + 1, y));
    }

    peers
}

fn find_basin(input: Vec<Vec<usize>>, (x, y): (usize, usize)) -> HashSet<String> {
    let max_y = input.len();
    let max_x = input[0].len();

    find_peers((x, y), max_x, max_y)
        .into_iter()
        .fold(HashSet::from([format!("{},{}", x, y)]), |mut basin, (x2, y2)| {
            let n1 = input[y][x];
            let n2 = input[y2][x2];
            if n2 != 9 && n2 > n1 {
                basin.extend(find_basin(input.clone(), (x2, y2)));
                basin
            } else {
                basin
            }
        })
}
