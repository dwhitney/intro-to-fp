import { IO, io } from "fp-ts/lib/IO";


export type Point = void
export type Points = void
export type Chart = void
export type SVG = void

export const makePoints = (xs: Array<number>): IO<Points> => { xs; return io.of(undefined) }
export const plot = (points: Points): IO<Chart> => { points; return io.of(undefined) }
export const toSVG = (chart: Chart): IO<SVG> => { chart; return io.of(undefined) }
export const render = (xs: Array<number>): IO<SVG> => 
  makePoints(xs)
    .chain(plot)
    .chain(toSVG)

