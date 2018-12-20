

sealed trait Maybe[+A]{}

final case class Just[+A](value: A) extends Maybe[A]
final case object Nada extends Maybe[Nothing]

object Maybe{
  
  def fromMaybe[A](defaultValue: A)(maybe: Maybe[A]): A = maybe match {
    case Nada => defaultValue
    case Just(value) => value
  }
}




object Main extends App {
  
  trait UserLike{
    val first: String
    val last: String
  }

  case class User(first: String, middle: String, last: String) extends UserLike
  case class Employee(id: String, first: String, last: String) extends UserLike

  def fullName(userLike: UserLike): String = userLike match {
    case User(first, middle, last) => s"$first $middle $last"
  }

  fullName(Employee("12345", "Dustin", "Whitney"))
  
}
