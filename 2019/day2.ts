import { readFileStrSync } from "https://deno.land/std@v0.36.0/fs/mod.ts";

const execute = (program: number[], position = 0): number[] => {
  if (position >= program.length) {
    return program;
  }

  let result = [...program];
  let posA: number, posB: number, posC: number;
  posA = program[position + 1];
  posB = program[position + 2];
  posC = program[position + 3];

  switch (program[position]) {
    case 1:
      result[posC] = result[posA] + result[posB];
      return execute(result, position + 4);
    case 2:
      result[posC] = result[posA] * result[posB];
      return execute(result, position + 4);
    case 99:
      return result;
    default:
      console.error(`invalid opcode: ${program[position]}`);
      return result;
  }
};

const testProgram = (program: number[]) => {
  console.log({ input: program });
  console.log({ output: execute(program) });
};

const instructions = readFileStrSync("input/day2.txt")
  .split(",")
  .map(x => parseInt(x, 10));

let newProgram = [...instructions];
newProgram[1] = 12;
newProgram[2] = 2;
testProgram(newProgram);

// testProgram([1, 0, 0, 0, 99]);
// testProgram([2, 3, 0, 3, 99]);
// testProgram([2, 4, 4, 5, 99, 0]);
// testProgram([1, 1, 1, 4, 99, 5, 6, 0, 99]);
