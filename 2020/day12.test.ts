import { assertEquals } from "https://deno.land/std@0.81.0/testing/asserts.ts";
import { solvePart1, solvePart2 } from "./day12.ts";

const input = `F10
N3
F7
R90
F11`;

Deno.test("solvePart1", () => {
  assertEquals(solvePart1(input), 25);
});

Deno.test("solvePart2", () => {
  assertEquals(solvePart2(input), 286);
});
