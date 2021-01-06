const input = Deno.readTextFileSync("./input/13.txt");
const lines = input.split("\n");

function solvePart1(input: string): number {
  const lines = input.split("\n");
  const timestamp = parseInt(lines[0], 10);
  const buses = lines[1].split(",").filter((bus) => bus !== "x").map((bus) =>
    parseInt(bus, 10)
  );
  const nextBuses = buses.map((bus) => ({
    bus,
    timestamp: bus * Math.ceil(timestamp / bus),
  }));
  const earliestBus = nextBuses.sort((a, b) => a.timestamp - b.timestamp)[0];
  return earliestBus.bus * (earliestBus.timestamp - timestamp);
}

export function solvePart2(input: string): number {
  const buses = input.split(",");
  let step = 1;
  let timestamp = 1;

  for (let i = 0; i < buses.length; i++) {
    const bus = buses[i];
    if (bus !== "x") {
      const id = parseInt(bus, 10);
      console.log({ id, step, offset: i });
      while ((timestamp + i) % id !== 0) {
        timestamp += step;
      }
      console.log({ timestamp, step });
      step = timestamp + i;
      console.log({ timestamp, step });
    }
  }

  return timestamp;
}

// const part1 = solvePart1(input);
// const part2 = solvePart2(lines[1]);
// console.log({ part1, part2 });
