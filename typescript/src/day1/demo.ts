import { IO, io } from "fp-ts/lib/IO";


const slope: IO<number> = io.of(1);

const xcoordinate: IO<number> = io.of(2);

const yintercept: IO<number> = io.of(3);

const y = (m: number) => (x: number) => (b: number) => m * x + b;

const program: IO<number> = 
  io.of(y)
    .ap_(slope)
    .ap_(xcoordinate)
    .ap_(yintercept)


console.log(program.run())
