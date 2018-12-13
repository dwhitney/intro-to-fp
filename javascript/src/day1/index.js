/* @flow */

"use strict";

type Y = (number, number, number) => number;
const y: Y = (m, x, b) => m * x + b;
const five: number = y(1, 2, 3);
console.log(five);

type Sum = Array<number> => number;
const sum: Sum = nums => {
  let total = 0;
  for(let num of nums){
    total += num;
  }
  return total;
}
console.log(sum([1,2,3]));

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

const foo = <A>(a: A): A => a

console.log(foo("foo"));

type NaturalNumber = number //pretend this is better than this :)
type YNat = (NaturalNumber, NaturalNumber, NaturalNumber) => NaturalNumber
const ynat: YNat = (m, x, b) => m * x + b


type User = String
type Password = String
type Username = String
type Either<A, B> = Either<A,B>

type GetByUsernameAndPassword = (Username, Password) => Either<Error, User>
const getByUsernameAndPassword: GetByUsernameAndPassword = (username, password) => null

