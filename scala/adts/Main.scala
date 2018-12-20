

object Main extends App{
  case class Street(var number: Int, var name: String)
  case class Address(var city: String, var street: Street)
  case class Company(var name: String, var address: Address)
  case class Employee(var name: String, var company: Company)

  val employee = Employee("john", Company("awesome inc", Address("london", Street(23, "high street"))))
  employee.company.address.street.name = employee.company.address.street.name.capitalize

  employee.copy(
    company = employee.company.copy(
      address = employee.company.address.copy(
        street = employee.company.address.street.copy(
          name = employee.company.address.street.name.capitalize
        )
      )
    )
  )

}


