import { assertEquals } from "https://deno.land/std@0.81.0/testing/asserts.ts";
import { solvePart2 } from "./day13.ts";

Deno.test("solvePart2", () => {
  assertEquals(solvePart2("17,x,13,19"), 3417);
  // assertEquals(solvePart2("7,13,x,x,59,x,31,19"), 1068781);
});
