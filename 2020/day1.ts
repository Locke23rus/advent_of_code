const input = Deno.readTextFileSync("./input/1.txt");
const numbers = input.trim().split("\n").map((i) => Number.parseInt(i, 10));

numbers.forEach((a) => {
  numbers.forEach((b) => {
    if (a + b === 2020) console.log(a * b);
    numbers.forEach((c) => {
      if (a + b + c === 2020) console.log(a * b * c);
    });
  });
});
