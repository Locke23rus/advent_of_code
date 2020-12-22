const input = Deno.readTextFileSync("./input/12.txt");

enum Direction {
  North = "North",
  South = "South",
  West = "West",
  East = "East",
}

interface StatePart1 {
  direction: Direction;
  [Direction.North]: number;
  [Direction.South]: number;
  [Direction.West]: number;
  [Direction.East]: number;
}

interface Point {
  x: number;
  y: number;
}

interface StatePart2 {
  ship: Point;
  waypoint: Point;
}

const directionDegrees = {
  [Direction.North]: 360,
  [Direction.East]: 90,
  [Direction.South]: 180,
  [Direction.West]: 270,
};

const initialStatePart1 = {
  direction: Direction.East,
  [Direction.North]: 0,
  [Direction.South]: 0,
  [Direction.West]: 0,
  [Direction.East]: 0,
};

const initialStatePart2 = {
  ship: { x: 0, y: 0 },
  waypoint: { x: -10, y: 1 },
};

export function solvePart1(input: string): number {
  return calculateDistancePart1(
    input.split("\n").reduce(performPart1, initialStatePart1),
  );
}

export function solvePart2(input: string): number {
  return calculateDistancePart2(
    input.split("\n").reduce(performPart2, initialStatePart2),
  );
}

function calculateDistancePart1(state: StatePart1): number {
  return Math.abs(state[Direction.North] - state[Direction.South]) +
    Math.abs(state[Direction.West] - state[Direction.East]);
}

function calculateDistancePart2(state: StatePart2): number {
  return Math.abs(state.ship.x) + Math.abs(state.ship.y);
}

function performPart1(state: StatePart1, instruction: string): StatePart1 {
  const action = instruction[0];
  const value = parseInt(instruction.slice(1), 10);

  switch (action) {
    case "N":
      return { ...state, [Direction.North]: state[Direction.North] + value };
    case "S":
      return { ...state, [Direction.South]: state[Direction.South] + value };
    case "W":
      return { ...state, [Direction.West]: state[Direction.West] + value };
    case "E":
      return { ...state, [Direction.East]: state[Direction.East] + value };
    case "F":
      return { ...state, [state.direction]: state[state.direction] + value };
    case "R":
      return { ...state, direction: rotateShip(state.direction, value) };
    case "L":
      return { ...state, direction: rotateShip(state.direction, 360 - value) };
  }

  return state;
}

function performPart2(state: StatePart2, instruction: string): StatePart2 {
  const action = instruction[0];
  const value = parseInt(instruction.slice(1), 10);

  switch (action) {
    case "N":
      return {
        ...state,
        waypoint: { ...state.waypoint, y: state.waypoint.y + value },
      };
    case "S":
      return {
        ...state,
        waypoint: { ...state.waypoint, y: state.waypoint.y - value },
      };
    case "W":
      return {
        ...state,
        waypoint: { ...state.waypoint, x: state.waypoint.x + value },
      };
    case "E":
      return {
        ...state,
        waypoint: { ...state.waypoint, x: state.waypoint.x - value },
      };
    case "F":
      return {
        ...state,
        ship: {
          x: state.ship.x + state.waypoint.x * value,
          y: state.ship.y + state.waypoint.y * value,
        },
      };
    case "R":
      return { ...state, waypoint: rotateWaypoint(state.waypoint, value) };
    case "L":
      return {
        ...state,
        waypoint: rotateWaypoint(state.waypoint, 360 - value),
      };
  }

  return state;
}

function rotateShip(direction: Direction, angle: number): Direction {
  let degrees = directionDegrees[direction] + angle;
  if (degrees === 0 || degrees % 360 === 0) return Direction.North;
  else if (degrees % 360 === 270) return Direction.West;
  else if (degrees % 360 === 180) return Direction.South;
  return Direction.East;
}

function rotateWaypoint(point: Point, angle: number): Point {
  if (angle === 0 || angle % 360 === 0) return point;
  else if (angle % 360 === 270) return { x: point.y, y: -point.x };
  else if (angle % 360 === 180) return { x: -point.x, y: -point.y };
  return { x: -point.y, y: point.x };
}

const part1 = solvePart1(input);
const part2 = solvePart2(input);
console.log({ part1, part2 });
