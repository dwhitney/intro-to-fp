object Demo extends App {
  
  trait UserLike{
    val first: String
    val last: String
  }

  case class User(first: String, middle: String, last: String) extends UserLike
  case class Employee(id: String, first: String, last: String) extends UserLike

  def fullName(userLike: UserLike): String = userLike match {
    case User(first, middle, last) => s"$first $middle $last"
  }

  //fullName(Employee("12345", "Dustin", "Whitney"))


  sealed trait Shape
  case class Square(height: Double, width: Double) extends Shape
  case class Circle(radius: Double) extends Shape

  def area(shape: Shape): Double = shape match {
    case Square(width, height) => width * height
    case Circle(radius) => java.lang.Math.PI * radius * radius
  }

  
}
