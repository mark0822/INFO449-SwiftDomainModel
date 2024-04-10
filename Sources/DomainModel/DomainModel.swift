struct DomainModel {
    var text = "Hello, World!"
        // Leave this here; this value is also tested in the tests,
        // and serves to make sure that everything is working correctly
        // in the testing harness and framework.
}

////////////////////////////////////
// Money
//
public struct Money {
    var amount : Int
    var currency : String
    
    func convert (_ c: String ) -> Money{
        var usdAmount: Int
        var convertedAmount : Int
        switch self.currency{
          case "GBP":
            usdAmount = self.amount * 2
          case "EUR":
            usdAmount = self.amount * 2 / 3
          case "CAN":
            usdAmount = self.amount * 4 / 5
          default:
            usdAmount = self.amount * 1
        }
        switch c{
          case "GBP":
            convertedAmount = usdAmount / 2
          case "EUR":
            convertedAmount = usdAmount * 3 / 2
          case "CAN":
            convertedAmount = usdAmount * 5 / 4
          default:
            convertedAmount = usdAmount * 1
        }
        return Money(amount: convertedAmount, currency: c)
    }
    
    func add (_ money: Money) -> Money {
        let convertedMoney = self.convert(money.currency)
        return Money(amount: convertedMoney.amount + money.amount, currency: money.currency)
    }
}

////////////////////////////////////
// Job
//
public class Job {
    var title : String
    var type: JobType
    public enum JobType {
        case Hourly(Double)
        case Salary(UInt)
    }
    init(title: String, type: JobType) {
        self.title = title
        self.type = type
    }
    func calculateIncome (_ hours: Int) -> Int {
        switch self.type{
          case .Salary(let salaryAmount):
            return Int(salaryAmount)
          case .Hourly(let hourlyAmount):
            return Int(hourlyAmount * Double(hours))
        }
    }
    func raise (byAmount: Double) {
        switch self.type{
          case .Salary(let salaryAmount):
            self.type = Job.JobType.Salary(salaryAmount + UInt(byAmount))
          case .Hourly(let hourlyAmount):
            self.type = Job.JobType.Hourly(hourlyAmount + byAmount)
        }
        return
    }
    
    func raise (byPercent: Double) {
        switch self.type{
          case .Salary(let salaryAmount):
            self.type = Job.JobType.Salary(UInt(Double(salaryAmount) * (1.0 + byPercent)))
          case .Hourly(let hourlyAmount):
            self.type = Job.JobType.Hourly(hourlyAmount * (1.0 + byPercent))
        }
        return
    }
}

////////////////////////////////////
// Person
//
public class Person {
    var firstName : String
    var lastName : String
    var age : Int
    private var _job : Job? = nil
    var job : Job? {
        get {
            return _job
        }
        set {
            if self.age >= 16 {
                _job = newValue
            } else {
                print("Too young to work")
            }
        }
    }
    var _spouse : Person? = nil
    var spouse : Person? {
        get {
            return _spouse
        }
        set {
            if self.age >= 18 {
                _spouse = newValue
            } else {
                print("Too young to get married")
            }
        }
    }
    
    init(firstName: String, lastName: String, age: Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
    }
    
    func toString () -> String {
        return "[Person: firstName:\(self.firstName) lastName:\(self.lastName) age:\(self.age) job:\(String(describing: self.job?.type)) spouse:\(String(describing: self.spouse?.firstName))]"
    }
}

////////////////////////////////////
// Family
//
public class Family {
    var members : [Person] = []
    
    init(spouse1 : Person, spouse2: Person) {
        if spouse1.spouse == nil && spouse2.spouse == nil {
            spouse1.spouse = spouse2
            spouse2.spouse = spouse1
            self.members.append(spouse1)
            self.members.append(spouse2)
        }
    }
    
    func haveChild (_ child : Person) -> Bool {
        if members[0].age < 21 && members[1].age < 21 {
            return false
        }
        self.members.append(child)
        return true
    }
    
    func householdIncome () -> Int {
        var totalIncome : Int = 0
        for person in members {
            if person.job != nil {
                switch person.job!.type{
                  case .Salary(let salaryAmount):
                    totalIncome += Int(salaryAmount)
                  case .Hourly(let hourlyAmount):
                    totalIncome += Int(hourlyAmount * 2000.0)
                }
            }
        }
        return totalIncome
    }
}
