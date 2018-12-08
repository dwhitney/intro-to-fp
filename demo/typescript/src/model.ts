import { Lens } from "monocle-ts"
import { Newtype, iso } from "newtype-ts"


//address
export interface Street extends Newtype<{readonly Street: unique symbol}, string>{}
export interface City extends Newtype<{readonly Street: unique symbol}, string>{}
export interface State extends Newtype<{readonly Street: unique symbol}, string>{}
export interface Zip extends Newtype<{readonly Street: unique symbol}, number>{}
export type Address = { readonly city: City, readonly state: State, readonly street: Street, readonly zip: Zip }

export const _street      = Lens.fromProp<Address>()("street");
export const _city        = Lens.fromProp<Address>()("city");
export const _state       = Lens.fromProp<Address>()("state");
export const _zip         = Lens.fromProp<Address>()("zip");
export const _streetIso   = iso<Street>()
export const _cityIso     = iso<City>()
export const _stateIso    = iso<State>()
export const _zipIso      = iso<Zip>()


//person
export interface FirstName extends Newtype<{readonly Street: unique symbol}, string>{}
export interface LastName extends Newtype<{readonly Street: unique symbol}, string>{}
export type Person = { readonly firstName: FirstName, readonly lastName: LastName, readonly address: Address }

export const _firstName     = Lens.fromProp<Person>()("firstName");
export const _lastName      = Lens.fromProp<Person>()("lastName");
export const _address       = Lens.fromProp<Person>()("address");
export const _firstNameIso  = iso<FirstName>()
export const _lastNameIso   = iso<LastName>()

/*
const address: Address = 
  { street : _streetIso.wrap("298 Waverly Ave.")
  , city   : _cityIso.wrap("Brooklyn")
  , state  : _stateIso.wrap("NY")
  , zip    : _zipIso.wrap(11205)
  }

const person: Person = 
  { firstName : _firstNameIso.wrap("Dustin")
  , lastName  : _lastNameIso.wrap("Whitney")
  , address   : address
  }

const brooklynLens = _address.compose(_city).composeIso(_cityIso)

console.log(brooklynLens.get(person))
*/
