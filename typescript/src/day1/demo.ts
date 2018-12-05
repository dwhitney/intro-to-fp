import { HKT } from "fp-ts/lib/HKT";
//import { IO, io, URI as IOURI } from "fp-ts/lib/IO";
import { Monad } from "fp-ts/lib/Monad";

// type classes

export interface Slope<E> {
  m : () => HKT<E, number>
}

export interface XCoordinate<E> {
  x : () => HKT<E, number>
}

export interface YIntercept<E> {
  b : () => HKT<E, number>
}

export interface Demo<M> extends Slope<M>, XCoordinate<M>, YIntercept<M>, Monad<M> {}


//const slopeIO: Slope<IOURI>

