/* @flow */

"use strict";

const { List } = require("immutable")

const y = (m: number, x: number, b: number): number => m * x + b;
const five: number = y(1, 2, 3);
console.log(five);

const sum = (nums: List<number>): number => {
  let total = 0;
  for(let num of nums){
    total += num;
  }
  return total;
}
console.log(sum(List([1,2,3])));

type Increment = () => void;
type GetCount = () => number;
let count: number = 0;
const increment: Increment = () => { count++; }
const getCount: GetCount = () => count;

const result: number = getCount();
increment();
result === getCount(); //false



type IsTodayOdd = () => boolean;
const isTodayDayOdd: IsTodayOdd = () => 
  (new Date().getDay() + 1) % 2 === 0

console.log(isTodayDayOdd())

type HelloWorld = () => void;
const helloWorld: HelloWorld = () => 
  console.log("Hello, World!")

helloWorld()

export opaque type NaturalNumber = number //pretend this is better than this :)
export const createNaturalNumber = (n: number): Either<Error, NaturalNumber> => undefined
type YNat = (NaturalNumber, NaturalNumber, NaturalNumber) => NaturalNumber
const ynat: YNat = (m, x, b) => m * x + b


type User = String
type Password = String
type Username = String
type Either<A, B> = Either<A,B>

type GetByUsernameAndPassword = (Username, Password) => Either<Error, User>
const getByUsernameAndPassword: GetByUsernameAndPassword = (username, password) => null


const foo = <A>(a: A): A => a

console.log(foo("foo"));

const foo2 = <A>(a: A, a2: A, combiner: (A,A) => A) =>
  combiner(a, a2)

console.log(foo2("a","b", ((a,b) => a + b)))

const reverse = (str: string): string =>
  (str) ? (reverse(str.slice(1)) + str[0])  : ""

console.log(reverse("Hello, World!"))

type Point = { x: number, y: number }
type Points = Array<Point>
type Chart = void 
type SVG = void 

const makePoints = (xs: Array<number>): Points => []
const plot = (points: Points): Chart => undefined
const toSVG = (chart: Chart): SVG => undefined
const render = (xs: Array<number>): SVG => 
  toSVG(plot(makePoints(xs)))

