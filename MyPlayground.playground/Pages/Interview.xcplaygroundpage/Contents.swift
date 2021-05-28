//: [Previous](@previous)

import Foundation
import XCTest




extension UserDefaults {
    static var shared: UserDefaults {
        let combined = UserDefaults.standard
        combined.addSuite(named: "group.johnsundell.app")
        return combined
    }
}

@propertyWrapper struct UserDefaultsBacked<Value> {
    let key: String
    var storage: UserDefaults = .standard

    var wrappedValue: Value? {
        get { storage.value(forKey: key) as? Value }
        set { storage.setValue(newValue, forKey: key) }
    }
}

struct SettingsViewModel {
    @UserDefaultsBacked<Bool>(key: "mark-as-read")
    var autoMarkMessagesAsRead

    @UserDefaultsBacked<Int>(key: "search-page-size")
    var numberOfSearchResultsPerPage
}

var set: Set<String> = []

set.insert("somethig")
set.contains("value:")




var str = "Hello, playground"
str.removeFirst()
print(str)
//: [Next](@next)
/*
var variableOne : Int? = 10
variableOne? = 20
print(variableOne ?? "default value of variableOne")
*/
var variableTwo : Int? = nil
variableTwo? = 20
print("variableTwo= ", variableTwo ?? "variableTwo") // variableTwo=  variableTwo
var variableOne : Int? = 10
variableTwo = variableOne //=> 20
print("variableTwo= ", variableTwo ?? "variableTwo") // variableTwo=  10


class stas {
    var type: String = "john"
    var age :Int = 10
}



var x = 5
func incr() -> Int {
    defer {
        //print("in defer")
        x += 1
    }
    //print("now x is \(x)")
    return x
}
print(" on x")
x = incr()
print(" after x = \(x)")
print(" on r")
let r = incr()
print(" after r = \(r)")
print(" on print")
print("x, r, x",x, r, x)


let  y = [15, 2, 67, 4, 5]

let sum = y.filter( { $0 < 10 }).map( { $0 *  2 } ).reduce(5, +)
print(sum)


let previous = [1, 2 ,3]

let current = 2
let array = Array(previous + [current]).suffix(2)
print(array)


let times = [
    "Hudson": "38",
    "Clarke": "42",
    "Robinson": "35",
    "Hartis": "DNF"
]

let finishers1 = times.compactMapValues { Int($0) }

let input = [-1, 0, 1, 2, -1, -4].sorted()
print("input = \(input)")


func binarySearch(array: [Int], element: Int) -> [Int] {
    print("searching : \(element) in array : \(array)")
    var start = 0
    var end = array.count - 1
    var mid = (start + end) / 2

    var result: [Int] = []
    while start <= end {
        let elementInMid = array[mid]
        if element == elementInMid {
            result.append(mid)
            for i in start..<mid {
                if element == array[i] {
                    result.append(i)
                }
            }
            if mid < end {
                for i in mid+1...end {
                    if element == array[i] {
                        result.append(i)
                    }
                }
            }
            break
        } else if elementInMid > element {
            end = mid - 1
            mid = (start + end) / 2
        } else {
            start = mid + 1
            mid = (start + end) / 2
        }
    }
    return result
}



func twoSum(array: [Int], sum: Int) -> [(Int , Int)?] {

    // add check for no and single item
    var subArray = array

    var resultArray:[(Int, Int)?] = []
    for i in 0..<array.count {
        let element = array[i]
        let complement = sum - element

        subArray.removeFirst()
        if subArray.isEmpty { break }
        let indexOfComplement = binarySearch(array: subArray, element: complement)

        for index in indexOfComplement {
            if i != index {
                resultArray.append((array[i], subArray[index]))
            }
        }

    }

    return resultArray
}
//print(twoSum(array: input, sum: 0))

func threeSum(array: [Int], sum: Int) -> [(Int , Int, Int)?] {
     
    var resultArray:[(Int, Int, Int)?] = []
    var subArray = array

    for i in 0..<array.count {
        let element = array[i]
        let complement = sum - element
        subArray.removeFirst()

        let indexes = twoSum(array: subArray, sum: complement)
        for item in indexes {

            if let firstValue = item?.0, let secondValue = item?.1 {
                let finalItem = (element, firstValue, secondValue)
                resultArray.append(finalItem)
            }
        }
    }
    return resultArray
}


//print("binary search index = ", binarySearch(array: input, element: 2))

print(threeSum(array: input, sum: 0))




// Binary tree questions

// search
// traversal --> pre , post and in order traversal using recursion
// copy binary tree
// level order traversal '



// Queue


struct Queue<T> {

    private var array:[T] = []

    func isEmpty() -> Bool {
        return array.isEmpty
    }

    func length() -> Int {
        return array.count
    }
    
    mutating func enque(value: T) {
        array.append(value)
    }

    mutating func deque() -> T? {
        if self.isEmpty() { return nil }
        let frontItem = array.removeFirst()
        return frontItem
    }
    
}





protocol Anyone {
    var name: String { get set }

}
struct Someone: Anyone {
    var name: String
}

class Employee: NSObject {
    var name: String = "default"
}
class myEmployee: Employee {

}



var emp1 = myEmployee()
print(emp1.name)




//Binary Tree
class Node {
    let value: Int
    var left: Node?
    var right: Node?
    init(value: Int) {
        self.value = value
    }
}

class BinaryTree {
    var root: Node
    init(root: Node) {
        self.root = root
    }

    func levelTraversal(current: Node) {
        var queue = Queue<Node>()
        queue.enque(value: current)

        var array: [Int] = []

        while !queue.isEmpty() {
            let node = queue.deque()
            array.append(node?.value ?? -1)
            if let lNode = node?.left {
                queue.enque(value: lNode)
            }
            if let rNode = node?.right {
                queue.enque(value: rNode)
            }
        }

        print(array)
    }

    func printNodes(current: Node?) {

        if current == nil {
            return
        }

        print(current?.value ?? "No value")

        printNodes(current: current?.left)
        printNodes(current: current?.right)

    }

    func addItem(value: Int, root: Node?) {
        if root == nil {
            self.root = Node(value: value)
        }
        var queue = Queue<Node>()
        queue.enque(value: self.root)

        var current = root
        while !queue.isEmpty() {
            guard let nodeValue = queue.deque()?.value else { break }
            if nodeValue > value {
                guard let node = current?.left else {
                    current?.left = Node(value: value)
                    break
                }
                current = node
                queue.enque(value: node)
            } else if nodeValue < value {
                guard let node = current?.right else {
                    current?.right = Node(value: value)
                    break
                }
                current = node
                queue.enque(value: node)
            } else {
                break
            }
        }

        print("inserting value = " , value)
        self.printNodes(current: root)


    }


}


let binaryTree = BinaryTree(root: Node(value: 10))

binaryTree.addItem(value: 7, root: binaryTree.root)
binaryTree.addItem(value: 8, root: binaryTree.root)
binaryTree.addItem(value: 12, root: binaryTree.root)

binaryTree.printNodes(current: binaryTree.root)
binaryTree.levelTraversal(current: binaryTree.root)

// DS programs :

//1: Sublist search : longest prefix suffix : https://www.youtube.com/watch?v=ziteu2FpYsA
// input = abcxabcd , abcd --> output -> true



// Leader problem
let inputArray: [Int] = [1,2,3,4,5,0]
var output:[Int] = []
for i in (0..<input.count).reversed() {
    print(inputArray[i])
    output.append(inputArray[i])
}

// assumption positive array
func leaders(input: [Int]) -> [Int] {
    var output: [Int] = Array.init(repeating: -1, count: input.count)
    var maxElement = -1
    for i in (0..<input.count).reversed() {
        print(i)
        let element = input[i]
        if element > maxElement {
            maxElement = element
            output[i] = maxElement
        } else {
            output[i] = -1
        }
    }
    return output
}

print(leaders(input: inputArray))



// reverse the binary tree


// max sum problem
let maxSumArray = [-2, 1, -3, 4, -1, 2,1 ,-5 ,4]
// expected output = 6

func maxSumArrayFunc(input: [Int]) -> Int {

    print( "------------ Maximum subarray -------- ")
    guard !input.isEmpty, let firstValue = input.first else {
        return 0
    }

    var tempSum = firstValue
    var maxSum = firstValue

    for i in 1..<input.count {
        print("value =  \(input[i])")
        print("tempSum = \(tempSum)")
        print("tempSum + input[i] = \(tempSum + input[i])")



        tempSum = max(tempSum + input[i], input[i])
        print("tempSum = \(tempSum)")
        maxSum = max(tempSum, maxSum)
        print("maxSum =  \(maxSum)")
        print( "------------")
    }
    return maxSum
}

print(maxSumArrayFunc(input: maxSumArray))


let target = [
[
"id": "1",
"name": "Rahul",
"subjects": ["Maths", "Hindi", "English"]
],
[
"id": "2",
"name": "Akshay",
"subjects": ["Maths", "Science", "English"]
],
[
"id": "3",
"name": "Varun",
"subjects": ["Hindi", "Science", "English"]
]
]
/*
let subjectList = target.compactMap {
    $0["subjects"]
} as! [[String]]

print(subjectList.flatMap { $0 })
*/
let subjectList = (target.compactMap {
    $0["subjects"]
} as! [[String]]).flatMap { $0 }
let subjects = Array(Set(subjectList))
//let array : [String: Any] = [String: Any]()
print(subjects)

/*
let subjectList = (target.compactMap {
    $0["subjects"]
} as! [[String]]).flatMap { $0 }
let subjects = Array(Set(subjectList))
//let array : [String: Any] = [String: Any]()
 */
print(subjects)


var binaryArray = Array(repeating: -1, count: 4)

func binary(n: Int) {
    if n < 1 {
        print(binaryArray)
        return
    }

    binaryArray[n-1] = 0
    binary(n: n - 1)

    binaryArray[n-1] = 1
    binary(n: n - 1)
}
binary(n: binaryArray.count)


var xyz : Int? = nil
xyz? = 20

print(xyz)


"""
Getting a Different Number
Given an array arr of unique nonnegative integers, implement a function getDifferentNumber that finds the smallest nonnegative integer that is NOT in the array.

Even if your programming language of choice doesn’t have that restriction (like Python), assume that the maximum value an integer can have is MAX_INT = 2^31-1. So, for instance, the operation MAX_INT + 1 would be undefined in our case.

Your algorithm should be efficient, both from a time and a space complexity perspectives.

Solve first for the case when you’re NOT allowed to modify the input arr. If successful and still have time, see if you can come up with an algorithm with an improved space complexity when modifying arr is allowed. Do so without trading off the time complexity.

Analyze the time and space complexities of your algorithm.
"""

func getDifferentNumber(arr: [Int]) -> Int {
    var min_num = 2^31-1

    let set:Set<Int> = Set(arr)

    if !set.contains(0) { return 0 }

    for i in 0..<arr.count
    {
        let pivot = arr[i] + 1
        if !set.contains(pivot) {
            if min_num > pivot {
                min_num = pivot
            }
        }
    }
    return min_num

    /*
    var sortedArray = arr.sorted(by:  { $0 < $1 } ) // O(nLogn)

    var arrayCount = sortedArray.count - 1

    guard let firstItem = sortedArray.first else { return -1 }

    if firstItem != 0 {
        return 0
    }


    for i in 0..<arrayCount {
        if (sortedArray[i+1] - sortedArray[i] > 1)
        {
            return sortedArray[i] + 1
        }
    }

    guard let lastItem = sortedArray.last else { return -1 }
    return lastItem + 1
 */
}

//print(getDifferentNumber(arr: [ 0,1,3, 4, 2]))



let string: String = "jhkjhjkh"

print(Array(string))


// acs ->

for i in string {
    print(i)
}


struct S1 {
    var arrayLet: [Int] = [0]


    func update( A: inout Array<Int>) {
        A = [2]

    }

    mutating func updateMutaing() {
        arrayLet = [3]
    }
}


var dummyStruct = S1()

dummyStruct.update(A: &dummyStruct.arrayLet)
print(dummyStruct.arrayLet)

dummyStruct.updateMutaing()
print(dummyStruct.arrayLet)



var optionalInteger: Optional<Int> = 1

var optionalInteger2: Int?

print(optionalInteger)
print(optionalInteger2)

switch optionalInteger {
case .none:
    print(optionalInteger)

case .some(let value):
    print(value)

default:
    break
}


@frozen
enum TestEnum: Int
{
    case A = 0
    case B
}
let v: TestEnum = .A

switch v {
case .A:
    break

case .B:
    break
@unknown default:
    break
}
