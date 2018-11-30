package day2.example3

object Combinable{
  def apply[A](implicit ev: Combinable[A]): Combinable[A] = ev
}

trait Combinable[A]{
  def combine(a : A, aa : A): A
}

object Example3 extends App{
  
  def append[A : Combinable](a : A, aa : A) : A = 
    Combinable[A].combine(a, aa)

  implicit object combinableInt extends Combinable[Int]{
    def combine(i : Int, ii : Int) = i + ii
  }

  val sum = append(5, 10) 
  println(sum)

  implicit object combinableString extends Combinable[String]{
    def combine(s : String, ss : String) = s + ss 
  }

  val concatted = append("hello", "world")
  println(concatted)

}
