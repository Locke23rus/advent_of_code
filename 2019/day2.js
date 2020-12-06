const fs = require("fs");
const readline = require("readline");

async function loadInstructions() {
  const fileStream = fs.createReadStream("day2_input.txt");
  const rl = readline.createInterface({
    input: fileStream
  });

  for await (const line of rl) {
    instructions = line.split(",").map(x => parseInt(x, 10));
  }
}

let instructions = [];

loadInstructions().then(() => {
  let newProgram = [...instructions];
  newProgram[1] = 12;
  newProgram[2] = 2;
  testProgram(newProgram);
});

const execute = (program, position = 0) => {
  if (position >= program.length) {
    return program;
  }

  let result = [...program];
  let posA, posB, posC;
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

const testProgram = program => {
  console.log({ input: program, output: execute(program) });
};

// testProgram([1, 0, 0, 0, 99]);
// testProgram([2, 3, 0, 3, 99]);
// testProgram([2, 4, 4, 5, 99, 0]);
// testProgram([1, 1, 1, 4, 99, 5, 6, 0, 99]);
