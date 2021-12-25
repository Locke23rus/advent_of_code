pub fn solve() {
    let input: Vec<Vec<usize>> = include_str!("./input/11.txt")
        .lines()
        .map(|line| line.chars().map(|n| n.to_string().parse().unwrap()).collect())
        .collect();

    // println!("{:?}", input);

    let part1: usize = count_flashes(input.clone(), 100);
    let part2: usize = find_simultaneous_flash(input.clone());

    println!("part 1: {}", part1);
    println!("part 2: {}", part2);
}

fn perform_step(grid: &mut Vec<Vec<usize>>) -> usize {
    let mut flashes: usize = 0;
    let size = grid.len();

    for y in 0..size {
        for x in 0..size {
            grid[y][x] += 1;
        }
    }

    while grid.clone().into_iter().any(|row| row.into_iter().any(|i| i > 9)) {
        for y in 0..size {
            for x in 0..size {
                if grid[y][x] > 9 {
                    grid[y][x] = 0;

                    find_peers((x, y), size).into_iter().for_each(|(x2, y2)| {
                        if grid[y2][x2] > 0 {
                            grid[y2][x2] += 1;
                        }
                    });
                }
            }
        }
    }

    for y in 0..size {
        for x in 0..size {
            if grid[y][x] == 0 {
                flashes += 1;
            }
        }
    }

    flashes
}

fn count_flashes(mut grid: Vec<Vec<usize>>, steps: usize) -> usize {
    let mut flashes: usize = 0;

    for _i in 0..steps {
        flashes += perform_step(&mut grid);
    }

    flashes
}

fn find_simultaneous_flash(mut grid: Vec<Vec<usize>>) -> usize {
    let mut step: usize = 1;
    let grid_size = grid.len();

    while perform_step(&mut grid) != grid_size * grid_size {
        step += 1;
    }

    step
}

fn find_peers(point: (usize, usize), size: usize) -> Vec<(usize, usize)> {
    let mut peers: Vec<(usize, usize)> = vec![];

    let min_x = if point.0 > 0 { point.0 - 1 } else { 0 };
    let min_y = if point.1 > 0 { point.1 - 1 } else { 0 };
    let max_x = if point.0 < size - 1 { point.0 + 1 } else { point.0 };
    let max_y = if point.1 < size - 1 { point.1 + 1 } else { point.1 };

    for y in min_y..=max_y {
        for x in min_x..=max_x {
            if !(x == point.0 && y == point.1) {
                peers.push((x, y));
            }
        }
    }

    peers
}
