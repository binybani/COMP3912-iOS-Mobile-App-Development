import UIKit
import Foundation

//var func1: (Int, Int) -> Int
//var func2: (String) -> Void
//let func3: () -> Int
//let func4: () -> [()->Void]
//let func5: ([(Int) -> Void]) -> [String]
//var func6: ([(Int) -> Void]) -> [(Int)->Void]
//var func7: ([(Int) -> Void]?) -> [(Int)->Void]?
//var func8: ([(Int) -> Void]?) -> [(Int)->Void]?
//var func9: () -> ((Int) -> Int, Int)?
//
//func fakeFunction1(a: Int, b: Int)->Int {
//    return a + b
//}
//
//func1 = fakeFunction1
//
//func fakeFunction2(s: String)->Void {
//    print(s)
//}
//
//func2 = fakeFunction2
//
//func fakeFunction3()->Int {
//    return 1
//}
//
//func3 = fakeFunction3
//
//func fakeFunction4()->[()->Void] {
//    let testFunction: ()->Void = {
//        print("Test Function")
//    }
//    return [testFunction]
//}
//
//func4 = fakeFunction4
//
//func fakeFunction5(arr: [(Int)->Void])->[String] {
//    return ["one", "Two", "Three", "Four"]
//}
//
//func5 = fakeFunction5
//
//func fakeFunction6(arr: [(Int)->Void])->[(Int)->Void] {
//    return arr
//}
//
//func6 = fakeFunction6
//
//func fakeFunction7(arr: [(Int)->Void]?)->[(Int)->Void]? {
//    return arr
//}
//
//func7 = fakeFunction7
//
//func fakeFunction8(arr: [(Int)->Void]?)->[(Int)->Void]? {
//    return arr
//}
//
//func8 = fakeFunction8
//
//func fakeFunction9()->((Int)->Int, Int) {
//    func testFunction(a: Int)->Int {
//        return a * 2
//    }
//
//    return (testFunction, 1)
//}
//
//func9 = fakeFunction9
//
//var stringArray: [String]
//let arraySize: Int = Int.random(in: 5...10)
//let operationsArray = ["sum", "division", "difference", "complement", "multiplication"]
//
//func sum(_ a: Int, _ b: Int) -> Double {
//    return Double(a + b)
//}
//
//func division(_ a: Int, _ b: Int) -> Double {
//    return Double(a / b)
//}
//
//func difference(_ a: Int, _ b: Int) -> Double {
//    return Double(a - b)
//}
//
//func complement(_ a: Int, _ b: Int) -> Double {
//    return pow(Double(a), Double(b))
//}
//
//func multiplication(_ a: Int, _ b: Int) -> Double {
//    return Double(a * b)
//}
//
//var dictionary: [String: (Int, Int) -> Double] = [
//    "sum": sum,
//    "division": division,
//    "difference": difference,
//    "complement": complement,
//    "multiplication": multiplication
//]
//
//func calculator(_ a: Int, _ b: Int, operation: String) -> (Double, String)?{
//    if let operationFunc = dictionary[operation] {
//        let result = operationFunc(a, b)
//        return (result, "the \(operation) function from the dictionary")
//    }
//    return nil
//}
//
//for operation in operationsArray {
//    let a = 10
//    let b = 20
//    if let result = calculator(a, b, operation: operation) {
//        print(result)
//    } else {
//        print("Invalid operation: \(operation)")
//    }
//}
//
//
//var sortedWords: [String] = []
//let criteria: [String: (String, String) -> Bool] = [
//    "ascendingly":ascendingly,
//    "descending":descending,
//    "lengthDescending":lengthDescending
//]
//func ascendingly(word1: String, word2: String)->Bool {
//    return word1 < word2
//}
//func descending(word1: String, word2: String)->Bool{
//    return word1 > word2
//}
//func lengthDescending(word1: String, word2: String)->Bool{
//    return word1.count > word2.count
//}
//func sorter(_ list:[String]?, criteria by: (String, String)->Bool) -> [String]?{
//    guard let words = list else {
//        return nil
//    }
//    sortedWords = words.sorted(by: by)
//    return sortedWords
//}
//let list1 = ["one", "two", "three", "four", "five"]
//var result1 = sorter(list1, criteria: ascendingly)
//if let sortedResult = result1 {
//    print("Alphabetically Ascendingly",result1!)
//} else {
//    print("nil")
//}
//let list2 = ["one", "two", "three", "four", "five"]
//var result2 = sorter(list2, criteria: descending)
//if let sortedResult = result2 {
//    print("Alphabetically Descending",result2!)
//} else {
//    print("nil")
//}
//let list3 = ["aa", "aba", "b", "aabbb"]
//var result3 = sorter(list3, criteria: lengthDescending)
//if let sortedResult = result3 {
//    print("Descending based on the length of the items",result3!)
//} else {
//    print("nil")
//}
//
//let predicateArray: [String] = ["predicate1", "predicate2", "predicate3", "predicate4"]
//let numberList = [3, 5, 7, 10, 13, 14, 17, 21, 23, 28, 29, 35, 37]
//var filterdNums:[Int] = []
//func filter(num: [Int], predicate: (Int)->Bool) -> [Int] {
//
//}
//
//for predicate in predicateArray {
//    if let result = filter(num: numberList, predicate by predicate) {
//        print(result)
//    } else {
//        print("Invalid operation: \(operation)")
//    }
//}
//func predicate1(num: Int) -> Bool {
//    if num % 2 != 0 {
//        return true
//    } else {
//        return false
//    }
//}
//func predicate2(num: Int) -> Bool {
//    if num > 1 {
//        for numSelf in 2..<num {
//            if num / numSelf != 1 {
//                return false
//            } else {
//                return true
//            }
//        }
//    } else {
//        return false
//    }
//}
//func predicate3(num: Int) -> Bool {
//    if predicate1(num: num) && predicate2(num: num) {
//        return true
//    } else {
//        return false
//    }
//}
//func predicate4(num: Int) -> Bool {
//    if num % 7 != 0 {
//        return false
//    } else {
//        return true
//    }
//}
//

struct Date {
    var day: Int
    var month: Int
    var year: Int


    static func transferDate (_ number: Int){
        let dictionaryMonths: [Int: String] = [
            0: "January",
            1: "February",
            2: "March",
            3: "April",
            4: "May",
            5: "June",
            6: "July",
            7: "August",
            8: "September",
            9: "October",
            10: "November",
            11: "December"
        ]
        let daysInMonths = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

        if number < 1 || number > 365 {
            print("Enter proper number between 1 and 365")
        } else {
            var monthNumber = 0
            var addDays = 0
            var day = 0
            var leftNumber = number
            for days in daysInMonths {
                if leftNumber <= days {
                    day = leftNumber
                    break
                } else {
                    leftNumber = leftNumber - days
                }
//                addDays += days
                monthNumber += 1
//                if number <= addDays {
//                    break
//                }
            }
            if let monthString = dictionaryMonths[monthNumber]{

                print("The date of the number \(number) is 2023 \(monthString) \(leftNumber)")
            }
        }
    }
}


// 예시
Date.transferDate(2) // The date of the number 2 is January 2
Date.transferDate(31) // The date of the number 31 is 2023 January 31
Date.transferDate(90) // The date of the number 90 is 2023 March 31
Date.transferDate(365) // The date of the number 365 is 2023 December 31
Date.transferDate(500) // Enter proper number between 1 and 365

enum WeekDay: String {
    case sunday = "Sunday"
    case monday = "Monday"
    case tuesday = "Tuesday"
    case wednesday = "Wednesday"
    case thursday = "Thursday"
    case friday = "Friday"
    case saturday = "Saturday"
    static func findWeekDay (for date: Date) -> WeekDay {
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = "\(date.year) - \(date.month) - \(date.day)"
    }
}
// Test with a sample date
let testDate = Date(day: 25, month: 7, year: 2023)
