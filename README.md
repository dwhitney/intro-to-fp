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

### Parametric PolyMorphism / Higher Kinded Types / Constraints



### 


