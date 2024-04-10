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
    public enum JobType {
        case Hourly(Double)
        case Salary(UInt)
    }
}

////////////////////////////////////
// Person
//
public class Person {
}

////////////////////////////////////
// Family
//
public class Family {
}
