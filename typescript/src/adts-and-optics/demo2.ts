import { Either } from "fp-ts/lib/Either"
import * as t from "io-ts"

export const Person = t.type({
  firstName: t.string,
  lastName: t.string,
  age: t.number
});

export interface IPerson extends t.TypeOf<typeof Person>{}

export const either: Either<t.Errors, IPerson> = 
  Person.decode(JSON.parse('{"firstName":"Dustin", "lastName": "Whitney", "age": 39 }')) 


export const fullName = (person: IPerson): string => 
  person.firstName + " " + person.lastName 
