

export enum SHAPE_ENUM { CIRCLE, OVAL, SQUARE } 

export const hasEdges = (shape: SHAPE_ENUM): boolean => {
  switch(shape){
    case SHAPE_ENUM.CIRCLE: return false 
  }
  return true;
}

console.log(hasEdges(SHAPE_ENUM.OVAL))


export interface Circle {
  readonly _tag: "Circle"
  readonly radius: number
}

export interface Square {
  readonly _tag: "Square"
  readonly width: number
}

export type Shape = Circle | Square

export const area = (shape: Shape): number => {
  switch(shape._tag) {
    case "Circle": return Math.PI * shape.radius * shape.radius
    case "Square": return shape.width * 2
  }
}


