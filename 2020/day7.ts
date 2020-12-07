const input = Deno.readTextFileSync("./input/7.txt");

type Bags = Record<string, Record<string, number>>;
const bags: Bags = {};

input.trim().split("\n").forEach((line) => {
  const [color, content] = line.split(" bags contain ");
  bags[color] = {};
  if (content.includes("no other bags")) return;
  content.split(", ").forEach((bagInfo) => {
    const parts = bagInfo.split(" ");
    const amount = parseInt(parts[0], 10);
    const nestedColor = parts.slice(1, 3).join(" ");
    bags[color][nestedColor] = amount;
  });
});

function isBagIncludes(color: string): boolean {
  const nestedColors = Object.keys(bags[color]);
  return nestedColors.includes("shiny gold") ||
    nestedColors.some(isBagIncludes);
}

const part1 = Object.keys(bags).reduce(
  (acc, color) => isBagIncludes(color) ? acc + 1 : acc,
  0,
);

function countNestedBags(color: string): number {
  return Object.entries(bags[color]).map(([nestedColor, amount]) =>
    countNestedBags(nestedColor) * amount
  ).reduce((a, b) => a + b, 1);
}

const part2 = countNestedBags("shiny gold") - 1;

console.log({ part1, part2 });
