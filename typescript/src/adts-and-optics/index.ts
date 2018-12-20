
export interface User { 
  readonly _tag: "User"
  readonly firstName: string
  readonly middleName: string
  readonly lastName: string

}

export interface Street { num: number, name: string }
export interface Address { city: string, street: Street }
export interface Company { name: string, address: Address }
export interface Employee { name: string, company: Company }
export const employee: Employee = {name: 'john',company:{name:'awesome inc',address:{city:'london',street:{num: 23,name:'high street'}}}}

export const capitalize = (s: string): string => s.substring(0, 1).toUpperCase() + s.substring(1)
employee.company.address.street.name = capitalize(employee.company.address.street.name)

export const employee2 = {
  ...employee,
  company: {
    ...employee.company,
    address: {
      ...employee.company.address,
      street: {
        ...employee.company.address.street,
        name: capitalize(employee.company.address.street.name)
      }
    }
  }
}

export const bar = (str: string)  => {
  switch(str) {
    case "bar" : return "you got bar!"
  }
}

export interface Point {
  readonly _tag: "Point"
  readonly x: number
  readonly y: number
}

export const point = (x: number) => (y: number): Point => 
  ({ _tag: "Point", x, y })

export class Circle{
  readonly _tag: "Circle" = "Circle"
  readonly radius: number
  readonly point: Point
  constructor(_radius: number, _point: Point){
    this.radius = _radius
    this.point = _point
  }
}

export const circle = (radius: number) => (point: Point): Circle => 
  new Circle(radius, point)

export interface Just<A> {
  readonly _tag: 'Just'
  readonly value: A
}

export interface Nothing {
  readonly _tag: 'Nothing'
}


export type Maybe<A> = Just<A> | Nothing

export const just = <A>(value: A): Maybe<A> => ({ _tag: 'Just', value })

export const nothing = <A>(): Maybe<A> => ({ _tag: 'Nothing' })

export const fromMaybe = <A>(defaultValue: A) => (maybe: Maybe<A>): A => {
  switch (maybe._tag) {
    case 'Nothing': return defaultValue
    case 'Just' : return maybe.value
  }
}

export enum SHAPE { CIRCLE, OVAL, SQUARE } 

export const hasPoints = (shape: SHAPE): boolean => {
  switch(shape){
    case SHAPE.CIRCLE: return false 
  }
  return true;
}

console.log(hasPoints(SHAPE.OVAL))

const app: any = {}

export type LoginInfo = { username: string, password: string }
export type LoginResponse = void

const handleLogin = (loginInfo: LoginInfo): LoginResponse => {
  loginInfo
  return undefined
}

export const go = app.get("/", (req: any, res: any) => {
  res.send(JSON.stringify(handleLogin(req.body)))
});
