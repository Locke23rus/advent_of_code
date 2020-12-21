const input = Deno.readTextFileSync("./input/10.txt");
const numbers = input.split("\n").map((n) => parseInt(n, 10)).sort((a, b) =>
  a - b
);

const solvePart1 = () => {
  let output = 0;
  let diff1 = 0;
  let diff3 = 1;
  numbers.forEach((n) => {
    const diff = n - output;
    if (n > output && (diff <= 3)) {
      output += diff;
      if (diff === 1) {
        diff1++;
      } else if (diff === 3) {
        diff3++;
      }
    }
  });
  return diff1 * diff3;
};

const cache: Record<string, number> = {};

const distinctSequencesCount = (
  arr: number[],
): number => {
  const key = arr.join(",");
  const result = cache[key];
  if (result !== undefined) return result;
  if (arr.length < 3) {
    return 1;
  }
  const prev = arr[0];
  const next = arr[2];
  const diff = next - prev;
  const a = arr.slice(1);
  const b = [prev, ...arr.slice(2)];

  const count =
    (diff <= 3
      ? distinctSequencesCount(a) + distinctSequencesCount(b)
      : distinctSequencesCount(a));
  cache[key] = count;
  return count;
};

const solvePart2 = (): number => distinctSequencesCount([0, ...numbers]);

const part1 = solvePart1();
const part2 = solvePart2();
console.log({ part1, part2 });
