const input = Deno.readTextFileSync("./input/2.txt");
const lines = input.trim().split("\n");

const part1 = lines.reduce((acc, line) => {
  const parts = line.split(" ");
  const [min, max] = parts[0].split("-").map((i) => Number.parseInt(i, 10));
  const letter = parts[1][0];
  const password = parts[2];

  const lettersCount = [...password].reduce(
    (count, l) => l === letter ? count + 1 : count,
    0,
  );

  if (lettersCount >= min && lettersCount <= max) acc++;

  return acc;
}, 0);

console.log({ part1 });

const part2 = lines.reduce((acc, line) => {
  const parts = line.split(" ");
  const [min, max] = parts[0].split("-").map((i) => Number.parseInt(i, 10));
  const letter = parts[1][0];
  const password = parts[2];

  const a = password[min - 1];
  const b = password[max - 1];

  if (a !== b && (a === letter || b === letter)) acc++;

  return acc;
}, 0);

console.log({ part2 });
