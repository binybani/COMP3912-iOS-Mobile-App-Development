import UIKit
import Foundation

// Problem 1
class Student {
    var name: String
    var scores: [Float]

    init(name: String, scores: [Float]){
        self.name = name
        self.scores = scores
    }

    var average: Float {
        let totalScore = scores.reduce(0, +)
        let numberOfScores = Float(scores.count)
        return totalScore / numberOfScores
    }

    var description: String {
        return "Name: \(name), Average Score: \(average)"
    }
}

var students: [Student] = []

func generateList() {
    let names = ["John", "Jane", "Michael", "Emily", "William", "Olivia", "Daniel", "Sophia", "David", "Ava"]

    while students.count < 10  {
        if let name = names.randomElement() {
            let scores = [Float.random(in: 0..<100)]

            let student = Student(name: name, scores: scores)
            students.append(student)
        }
    }
}

func getHighestScore() -> Student? {
    var highestScoreStudent: Student?
    var highestScore: Float = 0.0

    for student in students {
        if student.average > highestScore {
            highestScore = student.average
            highestScoreStudent = student
        }
    }

    if let student = highestScoreStudent {
        print(student.description)
    }

    return highestScoreStudent
}

// Test 1: Generate a random array of students
generateList()
for student in students {
    print(student.description)
}
// Test 2: Find the top-ranked student
if let topStudent = students.max(by: { $0.average < $1.average }) {
    print("Top-ranked student: \(topStudent.name)")
} else {
    print("No students found")
}

// Problem 2
enum AppleDevice {
    case iPhoneXs, iPhoneXR, iPhone8, iPhone7

    var price: Int {
        switch self {
        case .iPhone7:
            return 750
        case .iPhone8:
            return 800
        case .iPhoneXR:
            return 1100
        case .iPhoneXs:
            return 1000
        }
    }
}

// Test 1
let iPhoneXs = AppleDevice.iPhoneXs
print("$", iPhoneXs.price)

// Test 2
let iPhone8 = AppleDevice.iPhone8
print("$", iPhone8.price)

// Problem 3
class MyNotification {
    var seen: Bool = false {
        willSet {
            print("Changing 'totalSeen' property from \(totalSeen) to \(newValue)")
        }
        didSet {
            if seen != oldValue {
                print("Property 'seen' updated. New value: \(seen)")
            }
        }
    }
    var totalSeen: Int = 0 {
        willSet {
            print("Changing 'totalSeen' property from \(totalSeen) to \(newValue)")
        }
        didSet {
            if totalSeen != oldValue {
                print("Property 'totalSeen' updated. New value: \(totalSeen)")
            }
        }
    }

    func searchIt(numbers:[Int], predicate: (Int)->Bool, observer: MyObserver) {
        for number in numbers {
            notification.seen = predicate(number)


            if predicate(number) {
                notification.totalSeen = number
                observer.notify(predicate: predicate, number: number)
            }
        }
        observer.printInfo(numbers: numbers)
    }

    func fillIt(size: Int) -> [Int] {
        var numberArray = [Int]()
        while numberArray.count < size {
            let randomNumber = Int.random(in: 1..<100)
            if !numberArray.contains(randomNumber) {
                numberArray.append(randomNumber)
            }
        }
        return numberArray
    }
}

let predicate1: (Int) -> Bool = { number in
    return number % 3 == 0
}

let predicate2: (Int) -> Bool = { number in
    return number % 2 == 0
}

class MyObserver {
    var holdsPredicate: Int = 0
    var totalPredicate: Int = 0
    var numbers: [Int] = []

    func notify(predicate: (Int) -> Bool, number: Int) {
        holdsPredicate += 1
        totalPredicate += number
        numbers.append(number)


        print("Predicate: \(predicate(number)) -> Number of holds: \(number)")
        print("Updated numbers array: \(numbers)")
    }

    func printInfo(numbers: [Int]) {
        print("The number of the predicate holds: \(holdsPredicate) total: \(totalPredicate)")
    }
}


// Teat 1: Generate random numbers
let notification = MyNotification()
let observer = MyObserver()
let randomNumbers = notification.fillIt(size: 5)
print(randomNumbers)

// Teat 2: Using predicate 1
print("Predicate 1")
notification.searchIt(numbers: randomNumbers, predicate: predicate1, observer: observer)

// Teat 3: Using predicate 2
print("Predicate 2")
notification.searchIt(numbers: randomNumbers, predicate: predicate2, observer: observer)

// Problem 4
class MySort {
    var items: [Int]
    var sorting: ([Int]) -> Void {
        fatalError("Subclasses must override the sorting computed property.")
    }

    init(items: [Int]) {
        self.items = items
    }

    class MyBubbleSort: MySort {
        override var sorting: ([Int]) -> Void {
            return { numbers in
                var sortedNumbers = numbers
                let n = sortedNumbers.count
                for i in 0..<n {
                    for j in 0..<(n-i-1) {
                        if sortedNumbers[j] > sortedNumbers[j+1] {
                            sortedNumbers.swapAt(j, j+1)
                        }
                    }
                }
                print(sortedNumbers)
            }
        }
    }

    class MyInsertionSort: MySort {
        override var sorting: ([Int]) -> Void {
            return { numbers in
                var sortedNumbers = numbers
                let n = sortedNumbers.count
                for i in 1..<n {
                    let key = sortedNumbers[i]
                    var j = i - 1
                    while j >= 0 && sortedNumbers[j] > key {
                        sortedNumbers[j+1] = sortedNumbers[j]
                        j -= 1
                    }
                    sortedNumbers[j+1] = key
                }
                print(sortedNumbers)
            }
        }
    }
}

func fillIt(size: Int) -> [Int] {
    var numberArray = [Int]()
    while numberArray.count < size {
        let randomNumber = Int.random(in: 1..<100)
        if !numberArray.contains(randomNumber) {
            numberArray.append(randomNumber)
        }
    }
    return numberArray
}

// Test 1: Generate random numbers
let randomNumbers2 = fillIt(size: 5)
print(randomNumbers2)
let sort = MySort(items: randomNumbers2)

// Problem 5
func palindromeIndex(s: String) -> Int {
    let characters = Array(s)
    var left = 0
    var right = characters.count - 1

    while left < right {
        if characters[left] != characters[right] {
            if isPalindrome(characters, left + 1, right) {
                return left
            }
            if isPalindrome(characters, left, right - 1) {
                return right
            }
            return -1
        }
        left += 1
        right -= 1
    }
    return -1
}

func isPalindrome (_ characters: [Character], _ left: Int, _ right: Int) -> Bool {
    var leftIndex = left
    var rightIndex = right

    while leftIndex < rightIndex {
        if characters[leftIndex] != characters[rightIndex] {
            return false
        }
        leftIndex += 1
        rightIndex -= 1
    }
    return true
}

// Test
let testCases = [
    "aaab",
    "baa",
    "aaa"
]

for testCase in testCases {
    let result = palindromeIndex(s: testCase)
    print("Input: \(testCase)")
    print("Palindrome Index: \(result)")
    print("-------------------")
}

// Problem 6
func missingNumbers(arr: [Int], brr: [Int]) -> [Int] {
    var sortedArr = arr.sorted()
    var sortedBrr = brr.sorted()

    var missingNumbers = [Int]()

    for number in sortedArr {
        if let index = sortedBrr.firstIndex(of: number) {
            sortedBrr.remove(at: index)
        } else {
            missingNumbers.append(number)
        }
    }

    missingNumbers.append(contentsOf: sortedBrr)
    return missingNumbers
}
// Test 1
let arr = [7,2,5,3,5,3]
let brr = [7,2,5,4,6,3,5,3]
print(missingNumbers(arr: arr, brr: brr))

// Test 2
let arr2 = [203, 204, 205, 206, 207, 208, 203, 204, 205, 206]
let brr2 = [203, 204, 204, 205, 206, 207, 205, 208, 203, 206, 205, 206, 204]
print(missingNumbers(arr: arr2, brr: brr2))

// Problem 7
struct Circle {
    var radius: Double
    static let PI = 3.14

    var area: Double {
        return Circle.PI * radius * radius
    }

    func printInfo() {
        print("Radius:", radius)
        print("Area:", String(format: "%.2f", area))
    }
}
// Test 1: Create a circle with a radius of 5.0
var circle1 = Circle(radius: 5.0)
circle1.printInfo()

// Test 2: Create another circle with a radius of 3.2
let circle2 = Circle(radius: 3.2)
circle2.printInfo()

// Test 3: Create sphere with a radius of 5
let sphereRadius = Circle(radius: 5.0)
let sphereArea = sphereRadius.area * 4
print("Sphere Radius:", sphereRadius.radius)
print("Sphere Area:", sphereArea)

// Problem 8
@propertyWrapper
struct CapitalCase {
    private var value: String = ""
    private let maximumLength: Int

    var wrappedValue: String {
        get{ self.value }
        set { self.value = newValue.prefix(maximumLength).uppercased() }
    }
    
    init(wrappedValue: String, maximumLength: Int) {
        self.maximumLength = maximumLength
        self.wrappedValue = wrappedValue
    }
    
    var  projectedValue: CapitalCaseProjection {
        let capitalized = (wrappedValue != value.uppercased())
        let truncated = max(wrappedValue.count - maximumLength, 0)
        return CapitalCaseProjection(capitalized: capitalized, truncated: truncated)
    }
    

}

struct CapitalCaseProjection {
    let capitalized: Bool
    let truncated: Int
}

struct Name {
    @CapitalCase(wrappedValue: "beanie", maximumLength: 5)
    var name: String
    @CapitalCase(wrappedValue: "example", maximumLength: 3)
    var name2: String
    @CapitalCase(wrappedValue: "BEANIE", maximumLength: 6)
    var name3: String

    func printProjection() {
        print($name.capitalized)
        print($name.truncated)
        print($name2.capitalized)
        print($name2.truncated)
        print($name3.capitalized)
        print($name3.truncated)
    }
}

let name = Name()
print(name.name)
print(name.name2)
print(name.name3)
name.printProjection()
