import UIKit
import Foundation




//problem1
//problem2
class Student{
    private var age = 10
    private var email = ""
    private var takenCourses = 6
    private var gpa = 68

    init(_ age: Int, _ email: String, _ takenCourses: Int, _ gpa: Int){
        self.age = age
        self.email = email
        self.takenCourses = takenCourses
        self.gpa = gpa
    }
    func getAge() -> Int {
        return age
    }
    func getEmail() -> String {
        return email
    }
    func gettakenCourses() -> Int {
        return takenCourses
    }
    func getgpa() -> Int {
        return gpa
    }
}

class Search{
    static func searchForStudents(list students: [Student], with condition: (Student)->Bool, their specification: (Student)->String,
    action perform: (String)->Void){

        for student in students{
            if condition(student){
                let spec = specification(student)
                perform(spec)
            }
        }
    }
}

let st1 = Student(23, "a.gmail.com", 5, 78)
let st2 = Student(22, "b.gmail.com", 8, 72)
let st3 = Student(19, "c.gmail.com", 7, 63)
let st4 = Student(25, "d.gmail.com", 6, 81)
let st5 = Student(24, "e.gmail.com", 4, 66)
let st6 = Student(22, "f.gmail.com", 7, 81)

var students:[Student] = []
students.append(st1)
students.append(st2)
students.append(st3)
students.append(st4)
students.append(st5)
students.append(st6)

let resultOver22 = Search.searchForStudents(list: students, with: { $0.getAge() >= 22 }, their: {$0.getEmail()}, action: { email in
    print("Email addreass: \(email)")
})
print("Between 20 and 23")
let resutBetween20And23 = Search.searchForStudents(list: students, with: { $0.getAge() >= 20 && $0.getAge() <= 23 }, their: {$0.getEmail()}, action: { email in
    print("Email addreass: \(email)")
})




//problem3
//Ellipse
class Ellipse {
    var a: Double
    var b: Double
    
    init(a: Double, b: Double) {
        self.a = a
        self.b = b
    }
    
    func formula(x: Double, y: Double) -> Double {
        return a * x * x + b * y * y
    }
}

//test ellipse:  5X^2+5Y^2 = 10
let testEllipse = Ellipse(a: 5, b: 5)
let result = testEllipse.formula(x: 1, y: 1)
print("Result: \(result)")

//Directory
struct Directory {
    let name: String
    let files: [String]
    let subDir: [Directory]
    
    func content() {
        print("Content Direcotry: \(name)")
        for file in files {
            print("File: \(file)")
        }
        for sub in subDir {
            print("Subdirectory: \(sub.name)")
        }
    }
}
let courseInfoFile = "Courseinfo.txt"
let sampleExamFile = "SampleExam.pdf"
let assignmentsDir = Directory(name: "Assignments", files: [], subDir: [])
let lecturesDir = Directory(name: "Lectures", files: [], subDir: [])
let iosProjectDir = Directory(name: "IOSProject", files: [courseInfoFile, sampleExamFile], subDir: [assignmentsDir, lecturesDir])

iosProjectDir.content()

//problem4
protocol Protocol1 {
    var property1: Int? { get set }
}
class Protocol1Class: Protocol1 {
    var property1: Int?
    init(property1: Int) {
        self.property1 = property1
    }
}

protocol Protocol2 {
    var property2: String { get }
}
class Protocol2Class: Protocol2 {
    var property2: String
    init(property2: String) {
        self.property2 = property2
    }
}

protocol Protocol3 {
    var property3: (Int?)->String { get }
}
class Protocol3Class: Protocol3 {
    var property3: (Int?)->String
    init(property3: @escaping (Int?)->String) {
        self.property3 = property3
    }
}
var list1: [Any] = []
var dictionary: [String: Any] = [:]

let item1 = Protocol1Class(property1: 100)
let item2 = Protocol2Class(property2: "Beanie")
let item3 = Protocol3Class(property3: { value in
    return "value is: \(value)"
})
dictionary[

//problem5
struct Item {
    var name: String
    var weight: Int
}

struct Bag {
    var items: [Item]

    func totalWeight() -> Int {
        return items.reduce(0) { $0 + $1.weight }
    }

    func heaviestItem() -> Item? {
        return items.max(by: { $0.weight < $1.weight })
    }

    func sortedItemsByWeight() -> [Item] {
        return items.sorted(by: { $0.weight < $1.weight })
    }
}

// Test
let key = Item(name: "Key", weight: 50)
let battery = Item(name: "Battery", weight: 40)
let watch = Item(name: "Watch", weight: 100)
let ring = Item(name: "Ring", weight: 30)
let iPhone = Item(name: "iPhone", weight: 300)
let cup = Item(name: "Cup", weight: 250)
let notebook = Item(name: "Notebook", weight: 150)

let myBag = Bag(items: [key, battery, watch, ring, iPhone, cup, notebook])

let totalWeight = myBag.totalWeight()
print("Total Wieght: \(totalWeight)")

if let heaviestItem = myBag.heaviestItem() {
    print("The highest weight in the suitcase: \(heaviestItem.name)")
} else {
    print("Empty bag")
}

let sortedItems = myBag.sortedItemsByWeight()
print("Items sorted based on their weight ascendingly:")
for item in sortedItems {
    print("\(item.name): \(item.weight)")
}

//problem6
private var myViewController: LoginViewController = {

    guard myViewController = UIStoryboard.myStoryboard.instantiateViewController(withIdentifier: LoginViewController.storyboardIdentifier) as LoginViewController else {
        fatalError("Wrong View Controller")
    }

    myViewController.doLogin = { in
        self.modifyView()
    }

    return myViewController
}()
