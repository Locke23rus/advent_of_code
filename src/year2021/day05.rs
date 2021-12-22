#[derive(Clone, Copy, Debug)]
struct Point(usize, usize);
#[derive(Clone, Copy, Debug)]
struct Line(Point, Point);

type Diagram = Vec<Vec<usize>>;

impl Point {
    fn from(str: &str) -> Point {
        let point = str.split_once(",").unwrap();
        Point(point.0.parse().unwrap(), point.1.parse().unwrap())
    }
}

impl Line {
    fn from(str: &str) -> Line {
        let line = str.split_once(" -> ").unwrap();
        Line(Point::from(line.0), Point::from(line.1))
    }

    fn is_vertical(&self) -> bool {
        self.0 .0 == self.1 .0
    }

    fn is_horizontal(&self) -> bool {
        self.0 .1 == self.1 .1
    }

    fn is_diagonal(&self) -> bool {
        !self.is_horizontal() && !self.is_vertical()
    }
}

fn draw_line(line: Line, diagram: &mut Diagram) {
    if line.is_vertical() {
        let x: usize = line.0 .0;
        let y_min: usize = line.0 .1.min(line.1 .1);
        let y_max: usize = line.0 .1.max(line.1 .1);
        (y_min..=y_max).into_iter().for_each(|y| diagram[y][x] += 1);
    } else if line.is_horizontal() {
        let y: usize = line.0 .1;
        let x_min: usize = line.0 .0.min(line.1 .0);
        let x_max: usize = line.0 .0.max(line.1 .0);
        (x_min..=x_max).into_iter().for_each(|x| diagram[y][x] += 1);
    } else {
        let length = line.0 .0.max(line.1 .0) - line.0 .0.min(line.1 .0);
        for i in 0..=length {
            let y = if line.0 .1 > line.1 .1 {
                line.0 .1 - i
            } else {
                line.0 .1 + i
            };
            let x = if line.0 .0 > line.1 .0 {
                line.0 .0 - i
            } else {
                line.0 .0 + i
            };
            diagram[y][x] += 1
        }
    }
}

fn count_overlaps(diagram: Diagram) -> usize {
    diagram
        .into_iter()
        .fold(0, |sum, row| sum + row.into_iter().filter(|&n| n >= 2).count())
}

pub fn solve() {
    let input: Vec<&str> = include_str!("./input/5.txt").lines().collect();
    // println!("{:?}", input);
    let lines: Vec<Line> = input.into_iter().map(|line| Line::from(line)).collect();
    let diagram_y: usize = lines
        .clone()
        .into_iter()
        .map(|line| line.0 .1.max(line.1 .1))
        .max()
        .unwrap();
    let diagram_x: usize = lines
        .clone()
        .into_iter()
        .map(|line| line.0 .0.max(line.1 .0))
        .max()
        .unwrap();
    let mut diagram: Diagram = vec![vec![0; diagram_x + 1]; diagram_y + 1];

    lines
        .iter()
        .filter(|line| line.is_horizontal() || line.is_vertical())
        .for_each(|line| {
            draw_line(line.clone(), &mut diagram);
        });

    let part1: usize = count_overlaps(diagram.clone());

    lines.iter().filter(|line| line.is_diagonal()).for_each(|line| {
        draw_line(line.clone(), &mut diagram);
    });

    let part2: usize = count_overlaps(diagram.clone());

    println!("part 1: {}", part1);
    println!("part 2: {}", part2);
}
