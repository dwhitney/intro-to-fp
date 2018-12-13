package day1

import cats._
import cats.implicits._
import cats.effect._

object Main extends App{

  def y(m : Int, x : Int, b : Int): Int = m * x + b
  val five = y(1, 2, 3)

  println(five)

  def sum(nums : List[Int]): Int = {
    var i, total = 0
    while(i < nums.size){
      total = total + nums(i)
      i = i + 1
    }
    return total;
  }

  var count: Int = 0
  def increment(): Unit = count = count + 1
  def getCount(): Int = count

  val zero = getCount()
  increment()
  println(zero == getCount()) //false



  println(sum(List(1, 2, 3)))
  
  def isTodayOdd(): Boolean = 
    new java.util.Date().getDay() % 2 == 1

  println(isTodayOdd())
  
  def helloWorld(): Unit = 
    println("Hello, World!")

  helloWorld()

  
  case class NaturalNumber private (n: Int)
  object NaturalNumber{
    def create(n: Int): Either[Throwable, NaturalNumber] = ???
  }

  def yNat(m: NaturalNumber, x: NaturalNumber, b: NaturalNumber): NaturalNumber = ???

  type Username = String
  type Password = String
  type User = String

  def getByUsernameAndPassword(username: Username, password: Password): Either[Throwable, User] = ???


  def foo[A](a: A): A = a

  println(foo("foo"))

  def foo[A](a: A, a1: A, combiner : (A, A) => A): A = combiner(a, a1)

  println(foo(1, 2, (a: Int, b: Int) => a + b))

  //val xs = List(1, 2, 3)
  type Points = (Int, Int)
  type Chart = Any
  type SVG = Any

  /*
  def makePoints(xs: List[Int]): List[Points] = ???
  def plot(points: List[Points]): Chart = ???
  def toSVG(chart: Chart): Chart = ???
  def render(xs: List[Int]): Chart = toSVG(plot(makePoints(xs)))
  */
  
  def makePoints(xs: List[Int]): IO[List[Points]] = ???
  def plot(points: List[Points]): IO[Chart] = ???
  def toSVG(chart: Chart): IO[SVG] = ???
  def render(xs: List[Int]): IO[SVG] = for {
    points  <- makePoints(xs)
    chart   <- plot(points)
    svg     <- toSVG(chart) 
  } yield svg 

  def render2(xs: List[Int]): IO[SVG] = 
    makePoints(xs)
      .flatMap(plot)
      .flatMap(toSVG)
  


}
