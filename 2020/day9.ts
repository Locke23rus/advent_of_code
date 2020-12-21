const input = Deno.readTextFileSync("./input/9.txt");
const numbers = input.split("\n").map((n) => parseInt(n, 10));
const PREAMBLE_SIZE = 25;

const isValidNumber = (preamble: number[], x: number) =>
  preamble.some((a) => preamble.some((b) => a !== b && (a + b) === x));

const solvePart1 = () => {
  for (let i = PREAMBLE_SIZE; i < numbers.length; i++) {
    const x = numbers[i];
    const isValid = isValidNumber(
      [...numbers].slice(i - PREAMBLE_SIZE, i),
      x,
    );
    if (!isValid) return x;
  }
};

const solvePart2 = () => {
  for (let i = 0; i < numbers.length; i++) {
    let seq = [];
    let sum = 0;
    for (let j = i; j < numbers.length; j++) {
      const x = numbers[j];
      seq.push(x);
      sum += x;
      if (sum > part1!) {
        break;
      } else if (sum === part1!) {
        return Math.min(...seq) + Math.max(...seq);
      }
    }
  }
};

const part1 = solvePart1();
const part2 = solvePart2();

console.log({ part1, part2 });
