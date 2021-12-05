pub fn solve() {
    let input = include_str!("./input/4.txt");
    // println!("{:?}", input);

    let (numbers, boards) = input.split_once("\n").unwrap();
    let numbers: Vec<&str> = numbers.split(",").collect();
    let boards: Vec<Vec<&str>> = boards.split("\n\n").map(|b| b.split_whitespace().collect()).collect();
    let mut marked_boards: Vec<Vec<&str>> = boards.clone();
    let mut winners: Vec<(isize, Vec<&str>)> = vec![];

    numbers.iter().for_each(|n| {
        marked_boards = marked_boards
            .iter()
            .map(|board| board.iter().map(|i| if i == n { "x" } else { i }).collect())
            .collect();

        let (new_winners, losers): (Vec<_>, Vec<_>) = marked_boards.iter().partition(|&board| is_winner(board.clone()));
        for board in new_winners {
            winners.push((n.parse().unwrap(), board.clone()));
        }
        marked_boards = losers.into_iter().map(|board| board.clone()).collect();
    });

    println!("part 1: {}", final_score(winners.first().unwrap().clone()));
    println!("part 2: {}", final_score(winners.last().unwrap().clone()));
}

fn final_score(winner: (isize, Vec<&str>)) -> isize {
    let score: isize = winner
        .1
        .iter()
        .map(|s| s.replace("x", "0").parse::<isize>().unwrap())
        .sum();

    score * winner.0
}

fn is_winner(board: Vec<&str>) -> bool {
    (0..5)
        .into_iter()
        .any(|i| (0..5).into_iter().map(|j| board[i * 5 + j]).all(|s| s == "x"))
        || (0..5)
            .into_iter()
            .any(|i| (0..5).into_iter().map(|j| board[i + 5 * j]).all(|s| s == "x"))
}
