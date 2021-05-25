import UIKit
import Foundation

var str = "Hello, playground"
//let c = str.removeFirst()
//let strChar = String(c)
//print(strChar)
//str.append(c)
//print(str)

// Generic Stack for equtable items
struct Stack<T:Equatable> {
    // Array to store items in memory
    var array:[T] = []

    func size() -> Int {
        return array.count
    }

    mutating func push(value: T) {
        array.append(value)
        print("After push Stack = ",array)
    }
    mutating func pop() -> T? {
        guard let value = array.last else { return nil }
        array.removeLast()
        print("After pop Stack = ",array)
        return value
    }

    func isEmpty() -> Bool {
        return array.count == 0
    }

    func peep() -> T? {
        return array.last ?? nil
    }
}




var stack = Stack<Int>()
stack.push(value: 3)
stack.push(value: 1)
stack.push(value: 2)
stack.push(value: 5)
stack.push(value: 4)
stack.push(value: 9)
stack.push(value: 0)




func removeElementFromStack(stack: Stack<Int>, itemFromTop: Int) -> Stack<Int> {
    var localStack = stack
    // Base condition
    if (itemFromTop == 1) {
        localStack.pop()
        return localStack
    }
    guard let topElement = localStack.pop() else { return localStack }
    // hypothecation
    localStack = removeElementFromStack(stack: localStack, itemFromTop: itemFromTop - 1)

    localStack.push(value: topElement)
    return localStack
}
print("input removeElementFromStack ->",stack)
let midElementIndex = stack.size()/2 + 1
stack = removeElementFromStack(stack: stack, itemFromTop: midElementIndex)
print("output removeElementFromStack ->",stack)

// [ 1,2,3,4,5]
func insertElementInBottomOfStack(stack: Stack<Int>, element: Int)-> Stack<Int> {
    var localStack = stack
    if localStack.size() == 0 {
        localStack.push(value: element)
        return localStack
    }

    guard let stackTop = localStack.pop() else { return localStack }
    localStack = insertElementInBottomOfStack(stack: localStack, element: element)
    localStack.push(value: stackTop)
    return localStack
}
print("input insertElementInBottomOfStack ->",stack)
stack = insertElementInBottomOfStack(stack: stack, element: 99)
print("output insertElementInBottomOfStack ->",stack)


func reverseAStackUsingRecursion(stack: Stack<Int>) -> Stack<Int> {
    var localStack = stack
    // base condition
    if localStack.size() == 1 {
        return localStack
    }

    guard let topElement = localStack.pop() else { return localStack }
    // hypothesis
    localStack = reverseAStackUsingRecursion(stack: localStack)

    // induction
    localStack = insertElementInBottomOfStack(stack: localStack, element: topElement)
    return localStack
}
print("input reverseAStackUsingRecursion ->",stack)
stack = reverseAStackUsingRecursion(stack: stack)
print("output reverseAStackUsingRecursion ->",stack)



// To be used for passing operator as closure for comparision
typealias Operator = (Int, Int) -> Bool

// To be used to determine the direction of traversal
enum Direction {
    case left
    case right
}
// Common function to return array of indexes for problem statement
func largestOrSmallestIndexes(arr: [Int], compareVia: @escaping Operator, direction: Direction) -> [Int] {
    // Created an empty stack to store Int Values
    var stack = Stack<Int>()

    // Array of size input for storing and returning result.
    var resultArray  = Array(repeating: -100, count: arr.count)

    // Closure to calculate and update Stack and result Array
    let closure :(Int, Operator) -> () = { index, compareVia in
        let item = arr[index]
        if stack.isEmpty() {
            resultArray[index] = -1
            stack.push(value: index)
        } else {
            while !stack.isEmpty() {
                guard let stackTop = stack.peep() else { break; }
                if compareVia(item, arr[stackTop]) {
                    stack.pop()
                    if stack.isEmpty() {
                        resultArray[index] = -1
                    }
                } else {
                    resultArray[index] = stackTop
                    break;
                }
            }
            stack.push(value: index)
        }
    }

    // Switch case to run loop based on the direction provided.
    switch direction {
    case .left:
        for index in 0..<arr.count {
            closure(index,compareVia)
        }
    case .right:
        for index in (0..<arr.count).reversed() {
            closure(index,compareVia)
        }
    }
    return resultArray
}



print(largestOrSmallestIndexes(arr: [60, 20, 50], compareVia: >, direction: .right)) // indexes of larger number to right -- correct
print(largestOrSmallestIndexes(arr: [60, 20, 50], compareVia: <, direction: .right)) // indexes of smaller number to the right - correct
print(largestOrSmallestIndexes(arr: [60, 20, 50], compareVia: >, direction: .left)) // indexes of greater number to the left - corect
print(largestOrSmallestIndexes(arr: [60, 20, 50], compareVia: <, direction: .left)) // indexes of smaller number to the left - corect


func histogramProblemUsingStack() -> Int {
    let inputArray = [6, 2, 5, 4, 5, 1, 6]
    let maxOnLeftArray = largestOrSmallestIndexes(arr: inputArray, compareVia: <, direction: .left) // indexes of smaller number to the left - corect
    var maxOnRightArray = largestOrSmallestIndexes(arr: inputArray, compareVia: <, direction: .right)  // indexes of smaller number to the right - correct

    maxOnRightArray[inputArray.count - 1] = inputArray.count

    var maxArea = 0
    for index in 0..<inputArray.count {
        let area = (maxOnRightArray[index] - maxOnLeftArray[index] - 1) * inputArray[index]
        if area > maxArea {
            maxArea = area
        }
    }
    return maxArea
}

histogramProblemUsingStack()


// [-1, -1 , 1 , 1, 3, -1 , 5 ] <- [6, 2, 5, 4, 5, 1, 6] ->  [1, 5, 3, 5, , 5 , -1 , -1]

// Brute force method for solving the problem
func HistogramArea() -> Int {
    let arr = [6, 2, 5, 4, 5, 1, 6]
    var maxOnLeftArray = Array(repeating: -1, count: arr.count)
    var maxOnRight  = Array(repeating: -1, count: arr.count)
    for i in 0..<arr.count { // 1
        for index in (0..<i).reversed()
        {
            if arr[index] < arr[i] {
                maxOnLeftArray[i] = index
                break;
            }
        }
        for index in i+1..<arr.count
        {
            if arr[index] < arr[i] {
                maxOnRight[i] = index
                break;
            }
        }
    }
    maxOnRight[arr.count - 1] = arr.count
    var maxArea = 0
    for index in 0..<arr.count {
        let area = (maxOnRight[index] - maxOnLeftArray[index] - 1) * arr[index]
        if area > maxArea {
            maxArea = area
        }
    }
    return maxArea
}


func tappingRainWater() -> Int {
    let arr = [2, 0, 2]
    var result = 0

    for i in 0..<arr.count {
        var left = arr[i]
        var right = arr[i]

        for j in 0..<i {
            left = max(arr[j], left)
        }

        for k in i+1..<arr.count {
            right = max(right, arr[k])
        }
        result = result + min(left, right) - arr[i]
    }
    return result
}
print(tappingRainWater())

//for index in (0..<5).reversed() {
//    print(index)
//}
HistogramArea()

// keep this function call here



// Common function to return array of indexes for problem statement
func largestOrSmallestIndexesNew(arr: [Int], compareVia: @escaping Operator, direction: Direction, storeIndex: Bool = true) -> [Int] {
    // Created an empty stack to store Int Values
    var stack = Stack<Int>()

    // Array of size input for storing and returning result.
    var resultArray  = Array(repeating: -100, count: arr.count)

    // Closure to calculate and update Stack and result Array
    let closure :(Int, Operator) -> () = { index, compareVia in
        let item = arr[index]
        if stack.isEmpty() {
            resultArray[index] = storeIndex ? -1 : arr[index]
            stack.push(value: storeIndex ? index : arr[index])
        } else {
            while !stack.isEmpty() {
                guard let stackTop = stack.peep() else { break; }
                if compareVia(item, storeIndex ? arr[stackTop] : stackTop) {
                    stack.pop()
                    if stack.isEmpty() {
                        resultArray[index] = storeIndex ? -1 : arr[index]
                    }
                } else {
                    resultArray[index] = stackTop
                    break;
                }
            }
            stack.push(value: index)
        }
    }

    // Switch case to run loop based on the direction provided.
    switch direction {
    case .left:
        for index in 0..<arr.count {
            closure(index,compareVia)
        }
    case .right:
        for index in (0..<arr.count).reversed() {
            closure(index,compareVia)
        }
    }
    return resultArray
}


///print(largestOrSmallestIndexesNew(arr: [2, 0, 2], compareVia: >, direction: .right, storeIndex: false))

func tappingRainWaterUsingStackSecond() -> Int {
    let arr = [2, 0, 2]
    var result = 0
    let maxArrayOnLeft = largestOrSmallestIndexesNew(arr: arr, compareVia: >, direction: .left, storeIndex: false) //larger on left
    let maxArrayOnRight = largestOrSmallestIndexesNew(arr: arr, compareVia: >, direction: .right, storeIndex: false) // larger on right
    for index in 0..<arr.count {
        result += min(maxArrayOnLeft[index], maxArrayOnRight[index]) - arr[index]
    }
    return result
}
print(tappingRainWaterUsingStackSecond())




//--------- optimized solution --------

// function is used to convert index to values as this specific problem needs values not indexes.
func convertIndexArrayToValueArray(indexArray: [Int], valueArray:[Int]) -> [Int] {
    var resultArray = Array(repeating: 0, count: indexArray.count)
    for (index, value) in indexArray.enumerated() {
        resultArray[index] = value == -1 ? valueArray[index] : valueArray[value]
    }
    return resultArray
}

func tappingRainWaterUsingStack() -> Int {
    let arr = [2, 0, 2]
    var result = 0
    let maxArrayOnLeft = largestOrSmallestIndexes(arr: arr, compareVia: >, direction: .left)
    let maxArrayOnRight = largestOrSmallestIndexes(arr: arr, compareVia: >, direction: .right)
    let maxArrayOnLeftValues = convertIndexArrayToValueArray(indexArray: maxArrayOnLeft, valueArray: arr)
    let maxArrayOnRightValues = convertIndexArrayToValueArray(indexArray: maxArrayOnRight, valueArray: arr)
    for index in 0..<arr.count {
        result += min(maxArrayOnLeftValues[index], maxArrayOnRightValues[index]) - arr[index]
    }
    return result
}

print(tappingRainWaterUsingStack())


// ---- stock span problem
//The stock span problem is a financial problem where we have a series of n daily price quotes for a stock and we need to calculate span of stock’s price for all n days.
//The span Si of the stock’s price on a given day i is defined as the maximum number of consecutive days just before the given day, for which the price of the stock on the current day is less than or equal to its price on the given day.
//For example, if an array of 7 days prices is given as {100, 80, 60, 70, 60, 75, 85}, then the span values for corresponding 7 days are {1, 1, 1, 2, 1, 4, 6}


func stockSpanBruteForce() {
    let inputArray = [10, 4, 5, 90, 120, 80 ]
    // expected output : [1, 1, 1, 2, 1, 4, 6]
    var resultArray = Array(repeating: -1, count: inputArray.count)
    for index in (0..<inputArray.count).reversed() {
        resultArray[index] = index + 1
        for i in (0..<index).reversed() {
            if inputArray[i] > inputArray[index] {
                resultArray[index] = index - i
                break;
            }
        }
    }
    print(resultArray)
}
//stockSpanBruteForce()

func stockSpanUsingStack(inputArray: [Int]) -> [Int]{
    // Create an empty array of size n, where n is size of input array and initialize with -1 as default values
    var resultArray = Array(repeating: -1, count: inputArray.count)
    // Create an empty stack
    var stack = Stack<Int>()
    // run loop from 0 to n
    for index in 0..<inputArray.count {
        // variable to store pivot value on which we will be doing processing
        let pivotValue = inputArray[index]
        // Base condition : if stack is empty then simply add pivot value to stack and store index + 1 as result for that pivot index
        if stack.isEmpty() {
            resultArray[index] = index + 1
            stack.push(value: index)
        } else {
            // Run below code until stack is empty or found greate value than pivot value.
            while !stack.isEmpty() {
                // "guard" is just to check optional value. in case accidently inserted nil.
                guard let stackTop = stack.peep() else { break; }
                // check if pivot value is greater than the value on stack top.
                if pivotValue >= inputArray[stackTop] {
                    // we need to pop the element from stack until we found greater value than pivot value.
                    stack.pop()
                    // we again land into base condition of stack is empty.
                    if stack.isEmpty() {
                        resultArray[index] = index + 1
                    }
                } else {
                    // if we found value greater than stack then calculate and populate index traveresed in result array.
                    resultArray[index] = index - stackTop
                    break;
                }

            }
            // then finally push the value to stack for next comparision.
            stack.push(value: index)
        }
    }
    return resultArray
}


let inputArray = [10, 5, 4, 5, 90, 120, 120 ]
print(stockSpanUsingStack(inputArray: inputArray))





/*

// Query Config will be in Marty Framework
class Configuration:NSObject {
    var accountNumberClosure: (() -> Int)? = nil

    override init() {
        super.init()
    }
    static let shared:Configuration = Configuration()
    func printSomething() {

        guard let closure = self.accountNumberClosure else {
            print("closure is nil")
            return
        }
        let value = closure()
        print(value)
    }

}

// Main Tab project VC
class TABViewControllerClass: NSObject {
    let closure: ()-> Int = {
        return 10
    }
    // will be called somewhere before tracking analytics. may be at setup in app delegate or some analytics handler.
    func setupAnalytics() {
        Configuration.shared.accountNumberClosure = self.closure
    }
    func trackFunction() {
        Configuration.shared.printSomething()
    }
}

// Usage
let tabVC = TABViewControllerClass()
tabVC.setupAnalytics()
tabVC.trackFunction()

*/

/*
protocol AnalyticsAccountQueries {
    var accountNumber: UInt { get }
    // other account queries here
}
class Configuration {
    var accountQueries: AnalyticsAccountQueries?
    // Same way we have to introduce location, venue queries.
}
/// Umbrella class for analytics framework
class Analytics {
    static var shared: Analytics = Analytics()
    var configuration: Configuration?

    func track() {
        print(configuration?.accountQueries?.accountNumber ?? "nothing")
    }
}
// Usage
///Always inject the configuration into the participating classes (for example AdobeTarget class) in analytics framework.
//That way we can write tests by not touching the shared object.
// In TAB app

//config.accountQueries = // class coforming to the protocol.



class TabVC: AnalyticsAccountQueries {
    var accountNumber: UInt = 10

    func setup() {
        let config: Configuration = Configuration()
        config.accountQueries = self
        Analytics.shared.configuration = config
    }

    func track() {
        Analytics.shared.track()
    }
}

*/

// wrong
enum ErrorEnum: Error {
    case bad
    case worse
    case terrible
}
func badFunction() throws {
    throw ErrorEnum.terrible
}

do {
    try badFunction()
} catch ErrorEnum.terrible {
    print("code was terrible")
} catch {
    print("error caught")
}

// right
class Location {
    var city: String
    init(_ city: String) {
        self.city = city
    }
}
var l1 = Location("London")
var l2 = l1
print(l1.city)
print(l2.city)
l2.city = "new York"
print(l1.city)
print(l2.city)


//right
func myFunc(x: inout Int) {
    var localX = x
    defer {
        x = localX
    }
    x = 11
}

class Model {
    let a: Model?
    init(a: Model) {
        self.a = a
    }
}

// right
var arg = 5
myFunc(x: &arg)
print(arg)

let number = [1,2,4,5,9]
let result = number.filter { $0 >= 5 }
print(result)

// right
var originArray = [1,2,3,4]
var secondaryArray = originArray
secondaryArray[2] = 5
print(originArray)

//was wrong
for i in stride(from: 1, to: 21, by: 5) {
    print(i)
}
//was wrong
let a = 2
let (b) = 2
let (c): Int = 2
print(a,b,c)

// wrong: option was not available
/*let data: [Any?] = ["red", nil, "apple", 42]
// Error : Protocol 'Hashable' can only be used as a generic constraint because it has Self or associated type requirements
for datum in data where !(datum is Hashable) {
    print(datum)
}
*/
// wrong
var names = ["kanya", "Lil Uzi Vert", "Tyga", "Drake"]
let nameTruncator = [names.remove(at: 0)]
print(names.count)

print("firstName \(nameTruncator)!")
print(names.count)


// right
enum Fruit:Int {
    case Apple = 1
    case Orange
    case Grape
    case Banana
}
let test = Fruit(rawValue: 3)
print(test ?? "default")

//right
let name = "Garfield"
switch name {
case "Garfield":
    fallthrough
case "pluto","scooby","lassie":
    print("dog")
default :
    print("not a dog")
}
//Answer : Dog

// wrong -> right answer : code will not compile
/*guard false else {
    print("condition not met")
    exit(0) // was missing in actual code
}
print("condition met")

*/

// Wrong
// =================================
var namesNew = ["Tom", "Dick", "Harry", "Bob"]

var names1 = namesNew.sorted { s1, s2 in
    s1 > s2
}

var names2 = namesNew.sorted { $0 > $1 }
var names3 = namesNew.sorted(by:  < )
print(names1)
print(names2)
print(names3)
/*
Answer :
["Tom", "Harry", "Dick", "Bob"]
["Tom", "Harry", "Dick", "Bob"]
["Bob", "Dick", "Harry", "Tom"]
*/

// =================================

enum ErrorsToThrow: Error {
    case nameIsEmpty
}
class Person {
    var name:String?
    init(name: String?) throws {
        guard let name = name else {
            throw ErrorsToThrow.nameIsEmpty
        }
        self.name = name
    }
}


let person1 = try? Person(name: nil)
//let person2 = try! Person(name: nil)

print(person1?.name ?? "default person1") // will be nil but enabling below code will lead to crash
//print(person2.name ?? "default person2") crashing on this

//Answer : No Object will be created. Program crashes
//Fatal error: 'try!' expression unexpectedly raised an error: __lldb_expr_41.ErrorsToThrow.nameIsEmpty: file __lldb_expr_41/DS-Stack.xcplaygroundpage, line 653

// =================================


func fullName() -> (firstName:String, lastName:String) {
    return ("rachel", "greene")
}
let resultName = fullName().0
print(resultName)

//Answer - rachel
// =================================

var ids = [1,2,3]
var cities = ["New York", "London", "Paris"]
var resultCities = Array(zip(ids, cities))
print(resultCities)
// Answer : [(1, "New York"), (2, "London"), (3, "Paris")]
// =================================

let (freshman, junior, senior) = ("jane", "jake", "june")
print(junior)
//Answer = jake
// =================================

let numbers = [1,2,3].flatMap { [$0, $0] }
print(numbers)
//Answer = [1, 1, 2, 2, 3, 3]
// =================================


/*
class Person2 {
    var name:String
    //Initializer does not override a designated initializer from its superclass
    override init(initialName: String) {
        name = initialName
    }
}
let person = Person2(initialName: "Jane")
person.name = "albert"
print(person.name)
 */
//Answer : Code will not compile
// =================================

let numbers2 = Array(1..<10)
print(numbers2.count)
//Answer : 9
// =================================

/*
// below code is of generic and multiplication don't work on string
 func double<T>(value: T) -> T {
    return value * 2 //annot convert return expression of type 'Int' to return type 'T'
}
print(double(value: 11))
 */
// Answer : Code will not compile


func double<T>(value: T) -> T where T: Numeric {
   return value * 2 //annot convert return expression of type 'Int' to return type 'T'
}
print(double(value: 11))


// nearest smaller number to left in an array

func nearestSmallerNumberToLeft(arr: [Int]) -> [Int] {
    var stack = Stack<Int>()
    var result: [Int] = []
    for i in 0..<arr.count {
        let value = arr[i]

        // If stack is empty that means no small element appeared so far and this is the very first element of the array.
        guard var stackTop = stack.peep(), !stack.isEmpty() else {
            // So result will be a special number for this case assuming it will be -1
            result.append(-1)
            // push the number in stack for next iteration
            stack.push(value: value)
            continue // continue for next value.
        }

        // if stack top is greter than the pivot value i.e. Arr[i] then pop the larget values.
        while stackTop > value {
            stack.pop() // poping the greater values until found the smaller one than arr[i]
            // safe guard for nil and empty stack
            guard let top = stack.peep() else {
                break
            }
            stackTop = top
        }
        // if no smaller element found than have to exit loop with default -1 value.
        guard let nextStackTop = stack.peep(), !stack.isEmpty() else {
            result.append(-1)
            stack.push(value: value)
            continue
        }
        // if smaller than pivot value is found then set that as result and push arr[i]
        result.append(nextStackTop)
        print("value",value)
        stack.push(value: value)
    }
    return result
}




func nearestSmallerNumberToRight(arr: [Int]) -> [Int] {
    var stack = Stack<Int>()
    var result: [Int] = Array.init(repeating: -1, count: arr.count)
    for i in (0..<arr.count).reversed() {
        let value = arr[i]

        // If stack is empty that means no small element appeared so far and this is the very first element of the array.
        guard var stackTop = stack.peep(), !stack.isEmpty() else {
            // So result will be a special number for this case assuming it will be -1
            result[i] = -1
            // push the number in stack for next iteration
            stack.push(value: value)
            continue // continue for next value.
        }

        // if stack top is greter than the pivot value i.e. Arr[i] then pop the larget values.
        while stackTop > value {
            stack.pop() // poping the greater values until found the smaller one than arr[i]
            // safe guard for nil and empty stack
            guard let top = stack.peep() else {
                break
            }
            stackTop = top
        }
        // if no smaller element found than have to exit loop with default -1 value.
        guard let nextStackTop = stack.peep(), !stack.isEmpty() else {
            result[i] = -1
            stack.push(value: value)
            continue
        }
        // if smaller than pivot value is found then set that as result and push arr[i]
        result[i] = nextStackTop
        print("value",value)
        stack.push(value: value)
    }
    return result
}

//print("nearestSmallerNumberToLeft --> ",nearestSmallerNumberToLeft(arr: [60, 20, 50]))
//print("nearestSmallerNumberToRight --> ",nearestSmallerNumberToRight(arr: [60, 20, 50]))



func nearestLargerNumberToLeft(arr: [Int]) -> [Int] {
    var stack = Stack<Int>()
    var result: [Int] = Array.init(repeating: -1, count: arr.count)
    for i in 0..<arr.count {
        let value = arr[i]

        // If stack is empty that means no small element appeared so far and this is the very first element of the array.
        guard var stackTop = stack.peep(), !stack.isEmpty() else {
            // So result will be a special number for this case assuming it will be -1
            result[i] = -1
            // push the number in stack for next iteration
            stack.push(value: value)
            continue // continue for next value.
        }

        // if stack top is greter than the pivot value i.e. Arr[i] then pop the larget values.
        while stackTop <= value {
            stack.pop() // poping the greater values until found the smaller one than arr[i]
            // safe guard for nil and empty stack
            guard let top = stack.peep() else {
                break
            }
            stackTop = top
        }
        // if no smaller element found than have to exit loop with default -1 value.
        guard let nextStackTop = stack.peep(), !stack.isEmpty() else {
            result[i] = -1
            stack.push(value: value)
            continue
        }
        // if smaller than pivot value is found then set that as result and push arr[i]
        result[i] = nextStackTop
        print("value",value)
        stack.push(value: value)
    }
    return result
}
print("nearestLargerNumberToLeft --> ",nearestLargerNumberToLeft(arr: [60, 20, 50]))

func nearestLargerNumberToRight(arr: [Int]) -> [Int] {
    var stack = Stack<Int>()
    var result: [Int] = Array.init(repeating: -1, count: arr.count)
    for i in (0..<arr.count).reversed() {
        let value = arr[i]

        // If stack is empty that means no small element appeared so far and this is the very first element of the array.
        guard var stackTop = stack.peep(), !stack.isEmpty() else {
            // So result will be a special number for this case assuming it will be -1
            result[i] = -1
            // push the number in stack for next iteration
            stack.push(value: value)
            continue // continue for next value.
        }

        // if stack top is greter than the pivot value i.e. Arr[i] then pop the larget values.
        while stackTop <= value {
            stack.pop() // poping the smaller values until found the bigger one than arr[i]
            // safe guard for nil and empty stack
            guard let top = stack.peep() else {
                break
            }
            stackTop = top
        }
        // if no bigger element found than have to exit loop with default -1 value.
        guard let nextStackTop = stack.peep(), !stack.isEmpty() else {
            result[i] = -1
            stack.push(value: value)
            continue
        }
        // if bigger than pivot value is found then set that as result and push arr[i]
        result[i] = nextStackTop
        print("value",value)
        stack.push(value: value)
    }
    return result
}
print("nearestLargerNumberToRight --> ",nearestLargerNumberToRight(arr: [60, 20, 50]))



// Implement Queue using Stack


//
