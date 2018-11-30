package day2.example2

object Combinable{

  implicit object combinableInt extends Combinable[Int]{
    def combine(i : Int, ii : Int) = i + ii
  }
  
  implicit object combinableString extends Combinable[String]{
    def combine(s : String, ss : String) = s + ss 
  }
 
  /** 
  * This is here for cosmetic reasons - it lets us do:
  * `def append[A : Combinable)(a: A, aa: A) = Combinable[A].combine(a, aa)`
  *
  * instead of making our function require an implicit value:
  * `def append[A](a: A, aa: A)(implicit combinable: Combanble[A]) = combinable.combine(a, aa)
  *  
  * I like the former syntax better 
  **/
  def apply[A](implicit ev: Combinable[A]): Combinable[A] = ev

}

trait Combinable[A]{
  def combine(a : A, aa : A): A
}

object Example2 extends App{
  
  def append[A : Combinable](a : A, aa : A) : A = 
    Combinable[A].combine(a, aa)

  def appendV2[A](a : A, aa : A)(implicit combinable: Combinable[A]) : A = 
    combinable.combine(a, aa)


  val sum = append(5, 10) 
  println(sum)

  val concatted = append("hello", "world")
  println(concatted)

}
