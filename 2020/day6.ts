const input = Deno.readTextFileSync("./input/6.txt");
const groups = input.trim().split("\n\n");

const part1 = groups.map((group) => new Set(group.replaceAll("\n", "")).size)
  .reduce((a, b) => a + b, 0);

const part2 = groups.map((group) => {
  const groupSize = group.split("\n").length;
  const answers = [...group.replaceAll("\n", "")].reduce(
    (acc, char) => ({ ...acc, [char]: (acc[char] || 0) + 1 }),
    {} as Record<string, number>,
  );
  return Object.values(answers).filter((a) => a === groupSize).length;
}).reduce((a, b) => a + b, 0);

console.log({ part1, part2 });
