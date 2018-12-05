package day1

import cats._
import cats.implicits._
import cats.effect._


object Implicits{

  implicit val slope = new Slope[IO]{
    def m: IO[Int] = IO(1)
  }
  implicit val xcoordinate = new XCoordinate[IO]{
    def x: IO[Int] = IO(2)
  }
  implicit val yintercept = new YIntercept[IO]{
    def b: IO[Int] = IO(3)
  }

}

object AlternativeImplicits {
  implicit val yintercept = new YIntercept[IO]{
    def b: IO[Int] = IO.fromEither(Either.catchNonFatal{
      print("Enter the y-intercept: ")
      scala.io.StdIn.readLine.toInt
    })
  }
}

object Slope{
  def apply[E[_]](implicit m: Slope[E]): Slope[E] = m
}
object XCoordinate{
  def apply[E[_]](implicit x: XCoordinate[E]): XCoordinate[E] = x
}
object YIntercept{
  def apply[E[_]](implicit b: YIntercept[E]): YIntercept[E] = b
}


trait Slope[E[_]]{
  def m(): E[Int]
}

trait XCoordinate[E[_]]{
  def x(): E[Int]
}

trait YIntercept[E[_]]{
  def b(): E[Int]
}

object Y{
  
  def y(m: Int, x: Int, b: Int) : Int = m * x + b

}

/**
 * Demo Notes: 
 *  0. Explain what we're looking at
 *  1. Switch out the implicits - use AlternativeImplicits.bio instead of Implicits.bio
 *  2. Show how each of the steps in the "Side Effects" slides can be achieved by building off `example1`
**/
object Demo extends App{
  import Implicits._
  import Y._
  
  val example1: IO[Int] = for {
    m <- Slope[IO].m
    x <- XCoordinate[IO].x
    b <- YIntercept[IO].b
  } yield y(m, x, b)

  println(example1.unsafeRunSync)

}

