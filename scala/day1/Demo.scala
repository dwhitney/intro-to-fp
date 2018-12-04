package day1

import cats._
import cats.implicits._
import cats.effect._


object Implicits{

  implicit val mio = new M[IO]{
    def m: IO[Int] = IO(1)
  }
  implicit val xio = new X[IO]{
    def x: IO[Int] = IO(2)
  }
  implicit val bio = new B[IO]{
    def b: IO[Int] = IO(3)
  }

}

object AlternativeImplicits {
  implicit val bio = new B[IO]{
    def b: IO[Int] = IO.fromEither(Either.catchNonFatal{
      print("Enter the y-intercept: ")
      scala.io.StdIn.readLine.toInt
    })
  }
}

object M{
  def apply[E[_]](implicit m: M[E]): M[E] = m
}
object X{
  def apply[E[_]](implicit x: X[E]): X[E] = x
}
object B{
  def apply[E[_]](implicit b: B[E]): B[E] = b
}


trait M[E[_]]{
  def m(): E[Int]
}

trait X[E[_]]{
  def x(): E[Int]
}

trait B[E[_]]{
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
    m <- M[IO].m
    x <- X[IO].x
    b <- B[IO].b
  } yield y(m, x, b)

  println(example1.unsafeRunSync)

}

