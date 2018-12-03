# Referential Transparency and Equational Reasoning

---

## Referential Transparency

An expression is called *referentially transparent* if it can be replaced with its corresponding value without changing the program's behavior. This requires that the expression is *pure*, that is to say the expression value must be the same for the same inputs and its evaluation must have no *side effects*.

###tl;dr 
*referentially transparent* functions are *pure* and have no *side effects*

---

## Pure Functions 
*Scala*

```scala
def y(m : Int, x : Int, b : Int): Int = m * x + b
val five = y(1, 2, 3)
```

*JavaScript*

```javascript
type Y = (number, number, number) => number;
const y: Y = (m, x, b) => m * x + b;
const five: number = y(1, 2, 3);
```
---

## Pure Functions
*Scala*

[.code-highlight: 2]
```scala
def y(m : Int, x : Int, b : Int): Int = m * x + b
val five = 5
```

*JavaScript*

[.code-highlight: 3]
```javascript
type Y = (number, number, number) => number;
const y: Y = (m, x, b) => m * x + b;
const five: number = 5;
```

---

## More Pure Functions

*JavaScript*

```javascript
type Sum = Array<number> => number;
const sum: Sum = nums => {
  let total = 0;
  for(let num of nums){
    total += num;
  }
  return total;
}

```

---
## More Pure Functions

*Scala*

```scala
def sum(nums: List[Int]): Int = {
  var i, total = 0
  while(i < nums.size){
    total = total + nums(i)
    i = i + 1
  }
  return total;
}
```
___

## Impure Functions

*Scala*

```scala
var count: Int = 0
def increment(): Unit = count = count + 1
def getCount(): Int = count
```

*JavaScript*

```javascript
type Increment = () => void;
type GetCount = () => number;
let count: number = 0;
const increment: Increment = () => { count++; }
const getCount: GetCount = () => count;
```

---

## Impure Functions

*Scala*

```scala
def isTodayOdd(): Boolean = 
  new java.util.Date().getDay() % 2 == 1
```

*JavaScript*

```javascript
type IsTodayOdd = () => boolean;
const isTodayDayOdd: IsTodayOdd = () => 
  (new Date().getDay() + 1) % 2 === 0

```

---

## More Impure Functions

*Scala*

```scala
def helloWorld(): Unit = 
  println("Hello, World!")
```

*JavaScript*

```javascript
type HelloWorld = () => void;
const helloWorld: HelloWorld = () => 
  console.log("Hello, World!")
```

---

## What makes a function impure?
[*noboddy quite agrees*](https://stackoverflow.com/questions/4865616/purity-vs-referential-transparency), but roughly if it performs side effects:

* I/O (disk, network, console)
* Gets a value from *outside of the program* (Dates, Random numbers)
* Modifies memory beyond its scope
* (De)Allocates memory (if you want to be pedantic)

--- 

## Side Effects
