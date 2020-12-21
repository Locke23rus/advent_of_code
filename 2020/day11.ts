const input = Deno.readTextFileSync("./input/11.txt");

enum Seat {
  Floor = ".",
  Empty = "L",
  Occupied = "#",
}

function solve(
  input: string,
  occupiedSeatsLimit: number,
  occupiedSeatsCounter: (seats: string[], x: number, y: number) => number,
): number {
  let oldInput = "", newInput = input;

  while (oldInput !== newInput) {
    oldInput = newInput;
    newInput = swapSeats(oldInput, occupiedSeatsLimit, occupiedSeatsCounter);
  }

  return [...newInput].reduce(
    (acc, seat) => seat === Seat.Occupied ? acc + 1 : acc,
    0,
  );
}

export function solvePart1(input: string): number {
  return solve(input, 4, countAdjacentOccupiedSeats);
}

export function solvePart2(input: string): number {
  return solve(input, 5, countNearestOccupiedSeats);
}

function swapSeats(
  oldInput: string,
  occupiedSeatsLimit: number,
  occupiedSeatsCounter: (seats: string[], x: number, y: number) => number,
): string {
  const oldSeats = oldInput.split("\n");

  return oldSeats.map((row, y) => {
    return [...row].map((seat, x) => {
      const occupiedSeats = occupiedSeatsCounter(oldSeats, x, y);
      if (seat === Seat.Empty && occupiedSeats === 0) {
        return Seat.Occupied;
      } else if (
        seat === Seat.Occupied && occupiedSeats >= occupiedSeatsLimit
      ) {
        return Seat.Empty;
      }
      return seat;
    }).join("");
  }).join("\n");
}

export function countAdjacentOccupiedSeats(
  seats: string[],
  x: number,
  y: number,
): number {
  const maxY = seats.length - 1;
  const maxX = seats[0].length - 1;
  const fromX = x > 0 ? x - 1 : 0;
  const toX = x >= maxX ? maxX : x + 1;
  const fromY = y > 0 ? y - 1 : 0;
  const toY = y >= maxY ? maxY : y + 1;
  let result = 0;

  for (let _y = fromY; _y <= toY; _y++) {
    for (let _x = fromX; _x <= toX; _x++) {
      if (seats[_y][_x] === Seat.Occupied && !(x === _x && y === _y)) result++;
    }
  }

  return result;
}

export function countNearestOccupiedSeats(
  seats: string[],
  x: number,
  y: number,
): number {
  const maxY = seats.length - 1;
  const maxX = seats[0].length - 1;
  const directions = [
    [0, -1],
    [0, 1],
    [1, -1],
    [1, 0],
    [1, 1],
    [-1, -1],
    [-1, 0],
    [-1, 1],
  ];

  return directions.map(([deltaX, deltaY]) => {
    let tmpX = x + deltaX, tmpY = y + deltaY;

    while (tmpX >= 0 && tmpX <= maxX && tmpY >= 0 && tmpY <= maxY) {
      const seat = seats[tmpY][tmpX];
      if (seat === Seat.Empty) return 0;
      else if (seat === Seat.Occupied) return 1;
      tmpX += deltaX;
      tmpY += deltaY;
    }

    return 0;
  }).reduce((a: number, b: number) => a + b, 0);
}

const part1 = solvePart1(input);
const part2 = solvePart2(input);
console.log({ part1, part2 });
