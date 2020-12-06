import { readFileStrSync } from "https://deno.land/std@v0.36.0/fs/mod.ts";

const data = readFileStrSync("input/day1.txt", { encoding: "utf8" })
  .split("\n")
  .map((x: string) => parseInt(x, 10));

const calculateFuel = (x: number): number => Math.floor(x / 3) - 2;

const recursiveCalc = (x: number): number => {
  const y = calculateFuel(x);
  return y > 0 ? y + recursiveCalc(y) : 0;
};

const sum1 = data.reduce((sum, i) => sum + calculateFuel(i), 0);
const sum2 = data.reduce((sum, i) => sum + recursiveCalc(i), 0);

console.log({ sum1, sum2 });
