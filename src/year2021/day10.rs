pub fn solve() {
    let input: Vec<&str> = include_str!("./input/10.txt").lines().collect();

    // println!("{:?}", input);

    let part1: usize = input.clone().into_iter().fold(0, |sum, line| {
        let mut stack: Vec<char> = vec![];

        for char in line.chars() {
            if char == '(' || char == '[' || char == '{' || char == '<' {
                stack.push(char);
            } else if char == ')' {
                match stack.pop() {
                    Some('(') => {}
                    _ => return sum + 3,
                }
            } else if char == ']' {
                match stack.pop() {
                    Some('[') => {}
                    _ => return sum + 57,
                }
            } else if char == '}' {
                match stack.pop() {
                    Some('{') => {}
                    _ => return sum + 1197,
                }
            } else if char == '>' {
                match stack.pop() {
                    Some('<') => {}
                    _ => return sum + 25137,
                }
            }
        }

        sum
    });

    let corrupted_stacks: Vec<Vec<char>> = input
        .clone()
        .into_iter()
        .filter_map(|line| {
            let mut stack: Vec<char> = vec![];
            for char in line.chars() {
                if char == '(' || char == '[' || char == '{' || char == '<' {
                    stack.push(char);
                } else if char == ')' {
                    match stack.pop() {
                        Some('(') => {}
                        _ => return None,
                    }
                } else if char == ']' {
                    match stack.pop() {
                        Some('[') => {}
                        _ => return None,
                    }
                } else if char == '}' {
                    match stack.pop() {
                        Some('{') => {}
                        _ => return None,
                    }
                } else if char == '>' {
                    match stack.pop() {
                        Some('<') => {}
                        _ => return None,
                    }
                }
            }

            if stack.len() == 0 {
                None
            } else {
                Some(stack)
            }
        })
        .collect();

    // println!("{:#?}", corrupted_stacks);

    let mut points: Vec<usize> = corrupted_stacks
        .into_iter()
        .map(|mut stack| {
            stack.reverse();
            stack.into_iter().fold(0, |points, char| match char {
                '(' => return points * 5 + 1,
                '[' => return points * 5 + 2,
                '{' => return points * 5 + 3,
                '<' => return points * 5 + 4,
                _ => return points,
            })
        })
        .collect();
    points.sort();

    // println!("{:?}", points);

    let part2 = points[points.len() / 2];

    println!("part 1: {}", part1);
    println!("part 2: {}", part2);
}
