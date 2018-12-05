package day1

import cats._
import cats.implicits._
import cats.effect._



/**
 * Demo Notes: 
 *  0. Explain what we're looking at
 *  1. Switch out the `pure` slope with the one from SideEffects
 *  2. Show how each of the steps in the "Side Effects" slides can be achieved by building off `example1`
**/
object Demo extends App{

  def slope: IO[Int] = IO(1)
  def xcoordinate: IO[Int] = IO(2)
  def yintercept: IO[Int] = IO(3)

  def y(m: Int, x: Int, b: Int): Int = m * x + b
  
  val example1: IO[Int] = for {
    m <- SideEffects.slope 
    x <- xcoordinate
    b <- yintercept 
  } yield y(m, x, b)

  println(example1.unsafeRunSync)

}

object SideEffects {

  def slope: IO[Int] = IO.fromEither(Either.catchNonFatal{
    print("Enter the slope: ")
    scala.io.StdIn.readLine.toInt
  })

}
