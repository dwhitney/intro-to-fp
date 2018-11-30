package day2.example1

object Example1 extends App{
  
  def id[A](a : A) : A = a
  def second[A](a: A, aa : A) : A = aa

  val num : Int = 5
  val sameNum : Int = id(num)
  val ten = second(num, 10)
  println(ten)

  val str : String = "asdf"
  val sameStr : String = id(str)
  val fdsa = second(str, "fdsa")
  println(fdsa)

}
