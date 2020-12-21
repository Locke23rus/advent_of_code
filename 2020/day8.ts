const lines = Deno.readTextFileSync("./input/8.txt").trim().split("\n");
let part1, part2;

function execute_part1(
  instructions: string[],
  acc: number = 0,
  offset: number = 0,
  logs = new Set(),
): number {
  if (logs.has(offset)) {
    return acc;
  } else {
    logs.add(offset);
    const instruction = instructions[offset];
    if (instruction.startsWith("acc")) {
      acc += parseInt(instruction.slice(4), 10);
      offset += 1;
    } else if (instruction.startsWith("nop")) {
      offset += 1;
    } else {
      offset += parseInt(instruction.slice(4), 10);
    }
    return execute_part1(instructions, acc, offset, logs);
  }
}
part1 = execute_part1(lines);

function execute_part2(
  instructions: string[],
  acc: number = 0,
  offset: number = 0,
  logs = new Set(),
): number | null {
  if (offset >= instructions.length) {
    return acc;
  } else if (logs.has(offset)) {
    return null;
  } else {
    logs.add(offset);
    const instruction = instructions[offset];
    const step = parseInt(instruction.slice(4), 10);
    if (instruction.startsWith("acc")) {
      acc += step;
      offset += 1;
    } else if (instruction.startsWith("nop")) {
      offset += 1;
    } else {
      offset += step;
    }
    return execute_part2(instructions, acc, offset, logs);
  }
}
part2;
lines.find((instruction, i) => {
  if (instruction.startsWith("acc")) return false;
  const instructions = [...lines];
  instructions[i] = instruction.startsWith("nop")
    ? instruction.replace("nop", "jmp")
    : instruction.replace("jmp", "nop");
  const result = execute_part2(instructions);
  if (result !== null) {
    part2 = result;
    return true;
  }
});

console.log({ part1, part2 });
