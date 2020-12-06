const input = Deno.readTextFileSync("./input/5.txt");
const lines = input.trim().split("\n");

const finder = (
  seat: string,
  lowerChar: string,
  lower: number,
  upper: number,
): number => {
  // console.log({ seat, char: seat[0], lower, upper });
  if (seat[0] === lowerChar) {
    return seat.length == 1 ? lower : finder(
      seat.slice(1),
      lowerChar,
      lower,
      upper - (upper - lower + 1) / 2,
    );
  } else {
    return seat.length == 1 ? upper : finder(
      seat.slice(1),
      lowerChar,
      lower + ((upper - lower + 1) / 2),
      upper,
    );
  }
};
const getSeatId = (seat: string): number => {
  const row = finder(seat.slice(0, 7), "F", 0, 127);
  const column = finder(seat.slice(7), "L", 0, 7);
  // console.log({ row, column });
  return row * 8 + column;
};

// console.log(getSeatId("FBFBBFFRLR"));

const freeSeatFinder = (seatIds: number[]): number => {
  const sorted = seatIds.sort((a, b) => a - b);
  for (let i = 1; i < sorted.length; i++) {
    const a = sorted[i - 1];
    const b = sorted[i];

    if ((b - a === 2) || (b - a === 9)) return b - 1;
  }
  return 0;
};

const seatIds = lines.map(getSeatId);
const part1 = Math.max(...seatIds);
const part2 = freeSeatFinder(seatIds);

console.log({ part1, part2 });
