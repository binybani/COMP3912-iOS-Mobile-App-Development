import UIKit

// Problem 1: Defining closure variables and constant
// Variable func1: (Int, Int) -> Int
var func1: (Int, Int) -> Int

// Variable func2: (String) -> Void
var func2: (String) -> Void

// Constant func3: () -> Int
let func3: () -> Int

// Constant func4: () -> [() -> Void]
let func4: () -> [() -> Void]

// Constant func5: ([(Int) -> Void]) -> [String]
let func5: ([(Int) -> Void]) -> [String]

// Variable func6: ([(Int) -> Void]) -> [(Int) -> Void]
var func6: ([(Int) -> Void]) -> [(Int) -> Void]

// Variable func7: ([(Int) -> Void]?) -> [(Int) -> Void]?
var func7: ([(Int) -> Void]?) -> [(Int) -> Void]?

// Variable func8: ([(Int) -> Void]?) -> [(Int) -> Void]?
var func8: ([(Int) -> Void]?) -> [(Int) -> Void]?

// Variable func9: () -> ((Int) -> Int, Int)?
var func9: () -> ((Int) -> Int, Int)?

// Problem 2: Dummy functions
// var func1: (Int, Int) -> Int
func fakeFunction1(a: Int, b: Int) -> Int {
    return a + b
}

func1 = fakeFunction1

// var func2: (String) -> Void
func fakeFunction2(s: String) -> Void {
    print(s)
}

func2 = fakeFunction2

// let func3: () -> Int
func fakeFunction3 () -> Int {
    return 40
}

// let func4: () -> [() -> Void]
func fakeFunction4() -> [() -> Void] {
    let testFunction: () -> Void = {
        print("test function")
    }
    return [testFunction]
}

func4 = fakeFunction4

// let func5: ([(Int) -> Void]) -> [String]
func fakeFunction5(arr:[(Int) -> Void]) -> [String] {
    return ["Hello", "This", "is", "Beanie"]
}

func5 = fakeFunction5

// var func6: ([(Int) -> Void]) -> [(Int) -> Void]
func fakeFunction6(arr:[(Int) -> Void]) -> [(Int) -> Void] {
    return arr
}

func6 = fakeFunction6

// var func7: ([(Int) -> Void]?) -> [(Int) -> Void]?
func fakeFunction7 (arr:[(Int) -> Void]?) -> [(Int) -> Void]? {
    return arr
}

func7 = fakeFunction7

// var func8: ([(Int) -> Void]?) -> [(Int) -> Void]?
func fakeFunction8 (arr:[(Int) -> Void]?) -> [(Int) -> Void]? {
    return arr
}

func8 = fakeFunction8

// var func9: () -> ((Int) -> Int, Int)?
func fakeFunction9() -> ((Int) -> Int, Int)? {
    return ({ num in num * 2 }, 42)
}
func9 = fakeFunction9

// Problem 3: A Calculator
// Define an array whose type is String
var stringArray = [String]()
// The size of the array is between 5-10 (pick an arbitrary number)
let arraySize = Int.random(in: 5...10)
// Initialize the array with some initial values
let initialValues: [String] = ["sum", "division", "difference", "power", "multiplication"]
// Define a function for each of the above mathematical operations
func sum (_ a: Int, _ b: Int) -> Double {
    return Double(a + b)
}
func division (_ a: Int, _ b: Int) -> Double {
    return Double(a) / Double(b)
}

func difference (_ a: Int, _ b: Int) -> Double {
    return Double(a - b)
}

func power (_ a: Int, _ b: Int) -> Double {
    return pow(Double(a), Double(b))
}
func multiplication (_ a: Int, _ b: Int) -> Double {
    return Double(a * b)
}
// Define a dictionary
let dictionary: [String: (Int, Int) -> Double] = [
    "sum": sum,
    "division": division,
    "difference": difference,
    "power": power,
    "multiplication": multiplication
]
//Define a function called calculator
func calculator(_ num1: Int, _ num2: Int, operation: String) -> (Double, (Int, Int) -> Double)? {
    if let operationFunction = dictionary[operation] {
        let result = operationFunction(num1, num2)
        //returns a tuple
        return (result, operationFunction)
    }
    return nil
}
// iterate over the items of the array of the operations
for operation in initialValues {
    let num1 = 10
    let num2 = 20

    if let result = calculator(num1, num2, operation: operation) {
        print( operation, result)
    } else {
        print("Invalid operation: \(operation)")
    }
}

// Problem 4: Sorted()
func sorter(_ list: [String]?, criteria by: (String, String) -> Bool) -> [String]? {
    guard let words = list else {
        return nil
    }
    let sortedWords = words.sorted(by: by)
    return sortedWords
}

// Criteria: Alphabetically Ascendingly
let list1 = ["one", "two", "three", "four", "five"]
let criteria1: (String, String) -> Bool = { $0 < $1 }

if let sortedList1 = sorter(list1, criteria: criteria1) {
    print("Alphabetically Ascending:", sortedList1)
} else {
    print("Invalid input list.")
}
// Criteria: Alphabetically Descending
let list2 = ["one", "two", "three", "four", "five"]
let criteria2: (String, String) -> Bool = { $0 > $1 }

if let sortedList2 = sorter(list2, criteria: criteria2) {
    print("Alphabetically Descending:", sortedList2)
} else {
    print("Invalid input list.")
}
// Criteria: Descending based on the length of the items
let list3 = ["aa", "aba", "b", "aabbb"]
let criteria3: (String, String) -> Bool = { $0.count > $1.count }

if let sortedList3 = sorter(list3, criteria: criteria3) {
    print("Descending based on length:", sortedList3)
} else {
    print("Invalid input list.")
}

// Problem 5: Query Builder
func filter(numbers: [Int], predicates: [(Int) -> Bool]) -> [Int]? {
    // empty filtered numbers array
    var filteredNumbers: [Int] = []
    // predicate each number
    for number in numbers {
        // return true if a number is odd, prime, prime and odd, and divisible by 7
        var includeNumber = true
        
        for predicate in predicates {
            if !predicate(number) {
                includeNumber = false
                break
            }
        }
        // if the number is odd, prime, prime and odd, and divisible by 7
        if includeNumber {
            // append filtered number array
            filteredNumbers.append(number)
        }
    }
    // if filteredNumbers is empty return nil if not return array
    return filteredNumbers.isEmpty ? nil : filteredNumbers
}

// Define the predicates
let predicates: [String: (Int) -> Bool] = [
    // odd
    "predicate1": {$0 % 2 != 0},
    // prime
    "predicate2": {
        number in
        if number < 2 {
            return false
        }
        for i in 2..<number {
            if number % i == 0 {
                return false
            }
        }
        return true
    },
    // odd and prime
    "predicate3": {
        number in
        let isPredicate1True: Bool
        let isPredicate2True: Bool

        if let predicate1 = predicates["predicate1"] {
            isPredicate1True = predicate1(number)
        } else {
            isPredicate1True = false
        }
        if let predicate2 = predicates["predicate2"] {
            isPredicate2True = predicate2(number)
        } else {
            isPredicate2True = false
        }
        return isPredicate1True && isPredicate2True
    },
    // divisible by 7
    "predicate4": {$0 % 7 == 0 }
]

// Add the predicates to a list
let allPredicates = ["predicate1", "predicate2", "predicate3", "predicate4"]

// Define the input list of numbers
let numberList = [3, 5, 7, 10, 13, 14, 17, 21, 23, 28, 29, 35, 37]

// Call the filter function
if let filteredNumbers = filter(numbers: numberList, predicates: allPredicates.compactMap { predicates[$0] }) {
    print("Filtered Number List:", filteredNumbers)
} else {
    print("No numbers found.")
}
