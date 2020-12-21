import { assertEquals } from "https://deno.land/std@0.81.0/testing/asserts.ts";
import {
  countAdjacentOccupiedSeats,
  countNearestOccupiedSeats,
  solvePart1,
  solvePart2,
} from "./day11.ts";

const input1 = `L.LL.LL.LL
LLLLLLL.LL
L.L.L..L..
LLLL.LL.LL
L.LL.LL.LL
L.LLLLL.LL
..L.L.....
LLLLLLLLLL
L.LLLLLL.L
L.LLLLL.LL`;

const input2 = `#.##.##.##
#######.##
#.#.#..#..
####.##.##
#.##.##.##
#.#####.##
..#.#.....
##########
#.######.#
#.#####.##`;

const lines2 = input2.split("\n");

const input3 = `.......#.
...#.....
.#.......
.........
..#L....#
....#....
.........
#........
...#.....`;

const lines3 = input3.split("\n");

Deno.test("countAdjacentOccupiedSeats", () => {
  assertEquals(countAdjacentOccupiedSeats(lines2, 0, 0), 2);
});

Deno.test("solvePart1", () => {
  assertEquals(solvePart1(input1), 37);
});

Deno.test("countNearestOccupiedSeats", () => {
  assertEquals(countNearestOccupiedSeats(lines3, 3, 4), 8);
});

Deno.test("solvePart2", () => {
  assertEquals(solvePart2(input1), 26);
});
