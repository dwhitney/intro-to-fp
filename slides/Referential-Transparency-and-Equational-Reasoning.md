# Referential Transparency and Equational Reasoning

---

## Referential Transparency

An expression is called *referentially transparent* if it can be replaced with its corresponding value without changing the program's behavior. This requires that the expression is *pure*, that is to say the expression value must be the same for the same inputs and its evaluation must have no *side effects*.

###tl;dr 
*referentially transparent* functions are *pure* and have no *side effects*

---

## Pure Functions 
*Math*

```
y(m, x, b) = m * x + b
five = y(1, 2, 3)
```
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

## Pure Functions: Substitution
*Math*

[.code-highlight: 2]
```
y(m, x, b) = m * x + b
five = 5

```
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

## More Pure Functions: Substitution?

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
## More Pure Functions: Substitution?

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

val zero = getCount()
increment()
zero == getCount() //false
```

*JavaScript*

```javascript
type Increment = () => void;
type GetCount = () => number;
let count: number = 0;
const increment: Increment = () => { count++; }
const getCount: GetCount = () => count;

const result: number = getCount();
increment();
result === getCount(); //false
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
Side effecting functions:

* Perform I/O (disk, network, console)
* Get values from *outside of the program* (dates, random numbers)
* Modify values beyond its scope

--- 

## Side Effects

Come down from your ivory tower, Poindexter. All I do all day is make side-effects! How do I get anything done if I can't do that!

---

### Side Effects: Pure Functions

```
y = m * x + b
```

---

### Side Effects: Side Effects

[.code-highlight: 2]
```
y = m * x + b
y = (e * m) * (e * x) + (e * b)
```

---

### Side Effects: Factor out Side Effects

[.code-highlight: 3]
```
y = m * x + b
y = (e * m) * (e * x) + (e * b)
y = e(m * x + b)
```

---

### Side Effects: Bind More Side Effects

[.code-highlight: 4]
```
y = m * x + b
y = (e * m) * (e * x) + (e * b)
y = e(m * x + b)
y = e(m * x + b) + e(5)
```
---

### Side Effects: Bind More Side Effects

[.code-highlight: 5]
```
y = m * x + b
y = (e * m) * (e * x) + (e * b)
y = e(m * x + b)
y = e(m * x + b) + e(5)
y = e(m * x + b + 5)
```
---

### Side Effects: Map in Pure Functions

[.code-highlight: 6]
```
y = m * x + b
y = (e * m) * (e * x) + (e * b)
y = e(m * x + b)
y = e(m * x + b) + e(5)
y = e(m * x + b + 5)
y = e(m * x + b + 5) + 10
```
---

### Side Effects: Map in Pure Functions

[.code-highlight: 7]
```
y = m * x + b
y = (e * m) * (e * x) + (e * b)
y = e(m * x + b)
y = e(m * x + b) + e(5)
y = e(m * x + b + 5)
y = e(m * x + b + 5) + 10
y = e(m * x + b + 5 + 10)
```
---

### Side Effects: Essence of FP 

```
y = m * x + b
y = (e * m) * (e * x) + (e * b)
y = e(m * x + b)
y = e(m * x + b) + e(5)
y = e(m * x + b + 5)
y = e(m * x + b + 5) + 10
y = e(m * x + b + 5 + 10)
```
#### FP is Essentially
* binding side effecting contexts together (*flatMap*)
* mapping pure functions into side effecting contexts (*map*)

---

## What does this look like in practice?

DEMO TIME

___

## Equational Reasoning










