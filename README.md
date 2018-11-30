# Intro to Functional Programming

## Pedagogy

To learn functional programming patterns I believe it's best to examine several concrete examples of patterns from several different angles to completely understand the it. Then once the pattern is undestood, abstract it. This approach is best described by Brent Yorgey [here](https://byorgey.wordpress.com/2009/01/12/abstraction-intuition-and-the-monad-tutorial-fallacy/), and it's the approach I use to teach.

## Motivation

### Is this worth knowing?

![cats type classes](cats.svg)

The above diagram is all of the type classes from the Cats library, a functional programming library for Scala. If you're seeing this for the first time and it feels overwhelming, you aren't alone. First, there's just a lot of things there. Second, the words are obscure. Third, in the back of your mind you may be thinking, "Facebook was built with PHP. Why do I need to know this?"

The main argument I'd put forth is that it's worth the brain cells. To understand what I mean take a look at the list of fads below:

* Java: EJB, Spring Framework, Hibernate
* Scala: Lift Web, Akka, Play
* Javascript: YUI, jQuery, React

Now take a look at these truths:

* y = mx + b
* f = ma
* e = mc^2

I've personally devoted a lot of brain cells to learning the fads listed above, and now that the fads are over, those brain cells are full of useless information. On the otherhand the equations listed in the "truts" list, are as useful today as they were when I first learned about them. Wouldn't it be nice if we could apply these kinds of truths to our everyday programming life? YES! This is what functional programming offers. 

In computer science courses we learned truths about data structures, algorithms, and their runtime characteristics, but the languages and patterns we have traditionally used in our everyday programming jobs haven't allowed us to build much on those truths or create new truths of our own. Applying functional programming concepts to a given language, or adopting a purely functional programming language allows us to do this, and because functional programming's roots are based in math, the truths that are learned will remain useful throughout your career.

## Curriculum 

### Referential Transparency / Equational Reasoning

*goal*

If our overall goal in using function programming is to bring the world of mathematics into our programming life, then it makes sense to start by looking at mathematic functions and how they differ from functions in our imperative programming languages. Setting syntax aside, the primary difference is the primary difference is that mathematical functions are referentially transparent (pure) and imperative functions allow for side effects. We'll walk through what this means, and show how you can still get things done without using side effects.

*lecture*

* Definition of referential transparency
  * examples of referentially transparent functions
* Discuss side effects and how we "factor them out" of our functions
  * examples of how this is done "in the large" (Free Monad, IO Monad)
* Discuss "Domain" and "Range/Codomain" of function and how types allow for "equational reasoning"
  * examples of these concepts at work in real code (case classes and opaque types)
  * show use of private constructors 

*hands-on*
* Referential Transparency
  * some problems from 99 problems in Scala
    * find the last element in a list
    * find the nth element in a list
    * sum a list of integers
* Equational Reasoning
  * given the following function definitions, informally list out the possible errors you think could occur in both 
    `def getUserByUsernameAndPassword(username : String, password : String) : Option[User]`
    `def getUserByUsernameAndPassword(username : Username, password : Password) : Option[User]`
  * write a function that takes two "numbers" and will never return a negative "number"

*discussion*
  * solve the problems and answer questions

### Parametric Polymorphism / Type Classes / Constraints / Higher Kinded Types

*goal*

The items listed in the title of this session are the tools for reuse in functional programming. We'll start with parametric polymorphism and build our way up to functions that use type class constraints. I'd like to introduce `Semigroup` and `Monoid` by way of constructing our own type classes with more familiar names, and then showing that they are the equivalent of `Semigroup` and `Monoid`. I'd like to end by showing two examples of `Monoid` that are more day-to-day useful than `String` and `Int` -- I'll show a `Monoid` instance for a parser in Scala and something that combines two 

*lecture*
  * Parametric Polymorphism
    * How many implementations are there for the following function:
      * `def foo(i : Int) : Int`
    * How many implementations are there for the following functions:
      * `def foo[A](a : A) : A`
      * `def foo2[A](a : A, aa : A) : A`
    * How could I call that function?
      ```scala
      def id[A](a : A) : A = a
      def first(a 

      val num : Int = 5
      val sameNum = id(num)

      val str : String = "asdf"
      val sameStr = id(str)
      ```
    * Cool, one implementation for many types, but not really that useful...
  * Type classes
    * Type classes describe functionality
    ```scala
    trait Combinable[A]{
      def combine(a : A, aa : A): A
    }
    ```
    * They are then made concrete as implicit values
    ```scala
    object Combinable{

      implicit object combinableInt extends Combinable[Int]{
        def combine(i : Int, ii : Int) = i + ii
      }
      
      implicit object combinableString extends Combinable[String]{
        def combine(s : String, ss : String) = s + ss 
      }
 
    }

    trait Combinable[A]{
      def combine(a : A, aa : A): A
    }
    ```
  * Constraints
    * Let's now revisit a polymorphic funtion 
    ```scala
    def append[A](a : A, aa : A) : A 
    ```
    * Again - how many valid impelmentations?
    
    * Now let's add a type constraint with our type class
    ```scala
    def append[A : Combinable](a : A, aa : A) : A 
   
    // or equivalently  

    def appendV2[A](a : A, aa : A)(implicit combinable: Combinable[A]) : A 
    ```
    * Now how many valid implementations are there? 
    ```
    def append[A : Combinable](a : A, aa : A) : A = 
      Combinable[A].combine(a, aa)

    // or equivalently

    def appendV2[A](a : A, aa : A)(implicit combinable: Combinable[A]) : A = 
      combinable.combine(a, aa)

    ```
    * Hey did you know that `Combinable` is also called `Semigroup`?!?
    ```
    import cats._
    import cats.implicits._

    def append[A : Semigroup](a : A, aa : A) : A = 
      Semigroup[A].combine(a, aa)

    // or equivalently

    def appendV2[A](a : A, aa : A)(implicit semigroup: Semigroup[A]) : A = 
      semigroup.combine(a, aa)

    ```
  * Higher Kinded Types
    more work to be done here...

*hands-on*
* Show them a definition of something called `CombinableWithEmpty[A]` that extends `Combinable[A]` but includes an addtional method called `empty` which returns an empty value for the given type. Then show a function called `def fold[A : CombinableWithEmpty](list : List[A]) = list.fold(CombinableWithEmpty.empty)((a, aa) => CombinableWithEmpty.append(a, aa))` and have them implement an instance of `CombinableWithEmpty[A]` for `Int` and `String` that will work with fold
* Have them implement an instance of `CombinableKind[[F[_]]` (discussed un the unfleshed out section "Higher Kinded Types") for the `Option` type 

*discussion*
* Solve the previous examples
* Show how `CombinableWithEmpty[A]` is an equivalent to `Monoid[A]`


### Day-To-Day: Functor / Applicative Functor / Traverse

*goal* 

This is both a place where focusing on practical examples and theory would be very good. So I want to define a `Functor` and show what happens when `map` is called on various Scala data structures, starting with `List`, and then `Option`, `Future`, and `Either`. I think it's important to start with `List` because it was an especially acute mental leap for me to go from mapping over a list to mapping over an Option. The two things seemed completely different, yet they are the same. Then I want to define `Applicative` and `Traverse` And then just do a bunch of examples of how to use their properties
 

### Applied Theory: Functor / Applicative Functor / Traverse

*goal*

Here I want to quickly review the type classes we've studied so far: `Semigroup`, `Monoid`, `Functor`, `Applicative`, `Traverse` and then I want to introduce a data structure called `Maybe`. It is the functional equivalent of `Option`. Then I want most of the day to be focused on having people implement instances of the reviewed type classes for this new type, with the ultimate goal of running it through some constrained functions that already work for various other data structures with instances already defined in cats.


### Day-to-Day: Monad

*goal* Take a look at `flatMap` and note the slight difference in type signature from `map`, defined in `Functor`. Show several examples of how `map` and `flatMap` work when used on `Option`, `Either`, `Future`, and `List`. Note how flow can be modified with `flatMap` but not `map`, and how this gives rise to the description `Monad` as an abstraction for sequencing. Then put a bunch of `Monad`s into for comprehensions and compare how it looks to chianed `flatMap`s. Describe the "Happy Path" and how `Monad` makes things "work" without needing a lot of extraneous flow control and error checking.

### Applied Theory: Monad

*goal* Introduce the `FlatMap` type class and how how it fits into the `Monad` type class. Then provide instances of `Monad` to our `Maybe` type from the previous "theory" day. Roam around and help, and finally show my own implementation

### Monad Transformers

*goal* 
Show the problem, that has likely been very painful for everyone, caused by the fact that `Monads` don't compose. Quickly introduce `OptionT` and `EitherT` and pay a bit of lip service to `Kleisli` before quickly moving onto `cats-mtl`. Then I'll have some people write the implementations for functions that force the combination of `Option`, `Either` and perhaps `Future`. 

### Reader / Writer / State

*goal* 

Notably in `cats-mtl` there three monads known as `Reader`, `Writer`, and `State`. They play a prominent role in what's known as `mtl style`. We'll go over how to use them and why you'd want to use them.

### ApplicativeError, MonadError 

### Effects

### Free Monad

### Optics









