import UIKit
import Foundation

// Problem 1
struct Date {
    var day: Int
    var month: Int
    var year: Int

    static func convertToDate(_ number: Int) -> Date{
        var remainNumber = number
        let daysOfMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
        var currentMonth: Int = 1
        for (index, days) in daysOfMonth.enumerated() {
            if remainNumber > days {
                remainNumber -= days
                currentMonth = index + 2
            } else {
                break
            }
        }
        let year = 2023
        let month = currentMonth
        let day = remainNumber

        return Date(day: day, month: month, year: year)
    }
}

enum Weekday: String {
    case sunday = "Sunday"
    case monday = "Monday"
    case tuesday = "Tuesday"
    case wednesday = "Wednesday"
    case thursday = "Thursday"
    case friday = "Friday"
    case saturday = "Saturday"

    static func getWeekday(_ date: Date) -> Weekday {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        guard let targetDate = dateFormatter.date(from: "\(date.year)-\(date.month)-\(date.day)") else {
            fatalError("Invalid date format")
        }

        let calendar = Calendar(identifier: .gregorian)
        let weekdayIndex = calendar.component(.weekday, from: targetDate)

        switch weekdayIndex {
        case 1:
            return .sunday
        case 2:
            return .monday
        case 3:
            return .tuesday
        case 4:
            return .wednesday
        case 5:
            return .thursday
        case 6:
            return .friday
        case 7:
            return .saturday
        default:
            fatalError("Invalid weekday index")
        }
    }
}


// Testing the static method with different numbers
let date1 = Date.convertToDate(32)
print(date1)

let date2 = Date.convertToDate(150)
print(date2)

let date3 = Date.convertToDate(365)
print(date3)

// Testing the Weekday enumeration
let weekDay1 = Weekday.getWeekday(date1)
print(weekDay1.rawValue)

let weekDay2 = Weekday.getWeekday(date2)
print(weekDay2.rawValue)

let weekDay3 = Weekday.getWeekday(date3)
print(weekDay3.rawValue)

// Problem 2
struct Point {
    var x: Int
    var y: Int

    mutating func reset () {
        x = 0
        y = 0
    }

    func printPoint() {
        print("The point is at coordinate [\(x),\(y)]")
    }

    static func average(_ points: [Point], coordinate: Character) -> Int? {
            guard coordinate == "x" || coordinate == "y" else {
                return nil
            }

            var sum: Int = 0
            for point in points {
                if coordinate == "x" {
                    sum += point.x
                } else {
                    sum += point.y
                }
            }

            let average = sum / points.count
            return average
        }
    static func vectorAverage(_ points: [Point]) -> Point? {
        guard let averageX = average(points, coordinate: "x"),
              let averageY = average(points, coordinate: "y") else {
            return nil
        }

        return Point(x: averageX, y: averageY)
    }

}

// Test
let points = [Point(x: 1, y: 2), Point(x: 3, y: 4), Point(x: 5, y: 6)]

if let averageX = Point.average(points, coordinate: "x") {
    print("Average X coordinate: \(averageX)")
} else {
    print("Invalid coordinate")
}

if let averageY = Point.average(points, coordinate: "y") {
    print("Average Y coordinate: \(averageY)")
} else {
    print("Invalid coordinate")
}
let vectorAverage = Point.vectorAverage(points)
vectorAverage?.printPoint()

// Problem 3
enum Calculator {
    case sum, subtraction, multiplication, division

    static func calculate(num1: Int, num2: Int, opt: Calculator) -> Int {
            switch opt {
            case .sum:
                return calculateSum(num1, num2)
            case .subtraction:
                return calculateSubtraction(num1, num2)
            case .multiplication:
                return calculateMultiplication(num1, num2)
            case .division:
                return calculateDivision(num1, num2)
            }
        }

    static func calculateSum(_ num1: Int, _ num2: Int) -> Int {
        return num1 + num2
    }

    static func calculateSubtraction(_ num1: Int, _ num2: Int) -> Int {
        return num1 - num2
    }

    static func calculateMultiplication(_ num1: Int, _ num2: Int) -> Int {
        return num1 * num2
    }

    static func calculateDivision(_ num1: Int, _ num2: Int) -> Int {
        return num1 / num2
    }
}

// Test 1: Addition
let result1 = Calculator.calculate(num1: 5, num2: 3, opt: .sum)
print(result1)

// Test 2: Subtraction
let result2 = Calculator.calculate(num1: 10, num2: 4, opt: .subtraction)
print(result2)

// Test 3: Multiplication
let result3 = Calculator.calculate(num1: 6, num2: 7, opt: .multiplication)
print(result3)

// Test 4: Division
let result4 = Calculator.calculate(num1: 20, num2: 5, opt: .division)
print(result4)

// Problem 4
class Search {
    var numbers:[Int] = []

    func reset() {
        numbers = []
    }

    func randomFill() {
        while numbers.count < 10 {
            let randomNumbers = Int.random(in: 1...100)
            if !numbers.contains(randomNumbers){
                    numbers.append(randomNumbers)
                }
        }
        numbers.sort()
    }

    static func linearSearch(numbers: [Int], target: Int) -> Bool {
        for number in numbers {
            if number == target {
                return true
            }
        }
        return false
    }

}

// Create an instance of the Search class
let search = Search()

// Test 1: Reset the array
search.reset()
print(search.numbers)

// Test 2: Fill the array with random numbers
search.randomFill()
print(search.numbers)

// Test 3: Perform linear search
let targetNumber = 42
let isFound = Search.linearSearch(numbers: search.numbers, target: targetNumber)
print("Number \(targetNumber) is found?: \(isFound)")

// Problem 5
struct Student {
    var firstName: String
    var lastName: String
    var address: String
    var birthYear: Int
    var gpa: Float
    
    static func printStudent(student: Student){
        print("First Name: \(student.firstName)")
        print("Last Name: \(student.lastName)")
        print("Address: \(student.address)")
        print("Year of Birth: \(student.birthYear)")
        print("GPA: \(String(format: "%.2f", student.gpa))")
    }
}

class Classroom {
    var students: [Student] = []
    
    func generateList() {
        let firstNames = ["John", "Jane", "Michael", "Emily", "William", "Olivia", "Daniel", "Sophia", "David", "Ava"]
        let lastNames = ["Smith", "Johnson", "Brown", "Davis", "Wilson", "Anderson", "Miller", "Taylor", "Thomas", "Clark"]
        let addresses = ["111 Main St", "222 Granville St", "333 Oak Ave", "444 Maple Rd", "555 Pine Dr", "666 Cedar Ln", "777 Spruce Ave", "888 Birch Rd", "999 Willow Dr", "000 Aspen Ln"]
        
        while students.count < 10  {
            if let firstName = firstNames.randomElement(),
               let lastName = lastNames.randomElement(),
               let address = addresses.randomElement() {
                let birthYear = Int.random(in: 1990...2005)
                let gpa = Float.random(in: 2.0...4.0)
                
                let student = Student(firstName: firstName, lastName: lastName, address: address, birthYear: birthYear, gpa: gpa)
                students.append(student)
            }
        }
    }
    
    func getHighestGpa() -> Student? {
        var highestGpaStudent: Student?
        var highestGpa: Float = 0.0
        
        for student in students {
            if student.gpa > highestGpa {
                highestGpa = student.gpa
                highestGpaStudent = student
            }
        }
        
        if let student = highestGpaStudent {
            Student.printStudent(student: student)
        }
        
        return highestGpaStudent
    }
}

// Create an instance of the Classroom class
let classroom = Classroom()

// Test 1: Generate a random array of students
classroom.generateList()
for student in classroom.students {
    print(student)
}

// Test 2: Find the student with the highest GPA
classroom.getHighestGpa()
