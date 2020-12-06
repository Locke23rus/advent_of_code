const fs = require("fs");
const readline = require("readline");

async function loadData() {
  const fileStream = fs.createReadStream("day1_input.txt");
  const rl = readline.createInterface({
    input: fileStream
  });

  for await (const line of rl) {
    data.push(parseInt(line, 10));
  }
}

const calculateFuel = x => Math.floor(x / 3) - 2;

const recursiveCalc = x => {
  const y = calculateFuel(x);

  return y > 0 ? y + recursiveCalc(y) : 0;
};

let data = [];

loadData().then(() => {
  const sum1 = data.reduce((sum, i) => sum + calculateFuel(i), 0);
  const sum2 = data.reduce((sum, i) => sum + recursiveCalc(i), 0);

  console.log({ sum1, sum2 });
});
