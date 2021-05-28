//: [Previous](@previous)

import Foundation
import UIKit

// Generic Stack for equtable items
struct Stack<T:Equatable> {

    // Array to store items in memory
    var array:[T] = []

    mutating func push(value: T) {
        array.append(value)
    }
    mutating func pop() -> T? {
        guard let value = array.last else { return nil }
        array.removeLast()
        return value
    }

    func isEmpty() -> Bool {
        return array.count == 0
    }

    func peep() -> T? {
        return array.last ?? nil
    }
}



var str = "Hello, playground"


//print from 1 -- n -> IBH ( induction, base condition, hypothesis)
// 1.2.3....  7
// base condition = minimum input
// minimum input 1 -> printing(1) -> 1,

// will print number from 1 ---- n
/*
func printing(n: Int) {

    // base condition
    if n == 1 {
        print(1)
        return
    }
    // hypothesis -> assumption based on data
    // printing(n) -> 1,2,3,4,5,6...,n-1, n
    // printing(n-1) -> 1,2,3,4,5,6 ...n-1
    // printing(1) -> 1
    printing(n: n-1) // based on hypothesis it will print 1....n-1

    // induction
    print(n)
}

printing(n: 20)
*/
//: [Next](@next)

/// Given a string as an input. We need to write a program that will print all non-empty substrings of that given string.
func substringsOfString(input: String, outputString: String) {
    var input = input
    if input.count == 0 {
        print("substring = ",outputString)
    }
    else {
        let character = input.removeFirst()
        let newOutput = "\(outputString)\(character)"
        substringsOfString(input: input, outputString: newOutput)
        substringsOfString(input: input, outputString: outputString)
    }
}

substringsOfString(input: "abc", outputString: "")

/// Factorial of a number using recursion : method used is IBH -> Induction-hypothecation-base condition
func factorial(input: Int) -> Int {
    // base condition - minimum input is 1 as factorial of 5 = 5*4*3*2*1
    if input == 1 {
        return input
    }
    // Hypothecation is that is factorial(N) returns factorial of 5 then factorial(N-1) will return factorial of N-1
    let factorialValue = factorial(input: input - 1)
    // Induction : in factorial(N) and factorial(n-1) only difference is that N need to be multiplied.
    let result = input * factorialValue
    return result
}

print(factorial(input:10))


// insert element at its sorted place in a sorted array eg. [0, 1, 5] and element is 2, then output [0,1,2,5]
func insertElementIn(array inputArray: [Int], element: Int) -> [Int] {
    //base condition
    // checking if there is no element in the array and of the last element is less than the inserting element.
    // simply append that to this array and return the array
    if inputArray.count == 0 || inputArray.last ?? 0 < element {
        var inputArray = inputArray
        inputArray.append(element)
        return inputArray
    }
    //copied to local variable as can not mutate parameter.
    var inputArray = inputArray
    // if the last element is less greater than the number about to insert.
    let lastElement = inputArray.removeLast()
    // hypothecation : assuming that the function will return the sorted array and we will insert this element at the last.
    inputArray = insertElementIn(array: inputArray, element: element)
    // induction : inserting the element to the last as this function insertElementIn will return the sorted array
    inputArray.append(lastElement)
    return inputArray
}
print(insertElementIn(array: [0,1,5], element: 2))

// sort array using recursion
func sortArrayUsingRecursion(inputArray: [Int]) -> [Int] {
    if inputArray.count == 0 {
        return []
    }

    var inputArray = inputArray
    let lastElement = inputArray.removeLast()
    // hypothecation is that this function will return the sorted array.
    inputArray = sortArrayUsingRecursion(inputArray: inputArray)
    // induction is that all we have to do is just insert the last element. and the array will be sorted
    inputArray = insertElementIn(array: inputArray, element: lastElement)
    print("resulting inputArray = ", inputArray)
    return inputArray
}


print(sortArrayUsingRecursion(inputArray: [2,3,1,0,5,6,1]))




func insertElementInSortedStack(stack: Stack<Int>, element: Int) -> Stack<Int> {
    // base condition
    var localStack = stack

    guard !stack.isEmpty(),
          let topPeepElement = stack.peep(),
          topPeepElement > element else {
        localStack.push(value: element)
        return localStack
    }

    if topPeepElement < element {
        localStack.push(value: element)
        return localStack
    }

    // stored top elemnt locally and will be added to stack after recursive call
    guard let topElement = localStack.pop() else {
        localStack.push(value: element)
        return localStack
    }

    // Hypothesis
    localStack = insertElementInSortedStack(stack: localStack, element: element)

    // Induction
    localStack.push(value: topElement)
    return localStack
}
// Input [1,3,5] , 2 , output= [1, 3, 5, 2]
var sOne = Stack<Int>()
sOne.push(value: 1)
sOne.push(value: 3)
sOne.push(value: 2)
sOne.push(value: 5)

print(insertElementInSortedStack(stack: sOne, element: 2))

// Sort a not nil integer stack using recursion
print("------------------------------------------------------------------------------------------\n")
func sortAStack(stack: Stack<Int>) -> Stack<Int> {

    // Base condition
    if stack.isEmpty() {
        return stack
    }

    var localStack = stack
    guard let topElement = localStack.pop() else { return localStack }
    // Hypothecation
    localStack = sortAStack(stack: localStack)

    // Induction
    localStack = insertElementInSortedStack(stack: localStack, element: topElement)
    return localStack
}

var stack = Stack<Int>()
stack.push(value: 3)
stack.push(value: 1)
stack.push(value: 2)
stack.push(value: 5)
stack.push(value: 4)
stack.push(value: 9)
stack.push(value: 0)
print("input->",stack)

stack = sortAStack(stack: stack)
print("output->",stack)

// Kth Symbol in grammer
/*
 Grammer =

        K 1 2 3 4 5 6 7 8
 N = 1 -> 0
 N = 2 -> 0 1
 N = 3 -> 0 1 1 0
 N = 4 -> 0 1 1 0 1 0 0 1

 Base condition = if k = 1 && N == 1 , return 0
 for 0 in upper row add 01 in next row
 for 1 in upper row add 10 in next row

 Examples:
 Input: N = 1, K = 1
 Output: 0

 Input: N = 2, K = 1
 Output: 0

 Input: N = 2, K = 2
 Output: 1

 Input: N = 4, K = 5
 Output: 1

 Explanation:
 row 1: 0
 row 2: 01
 row 3: 0110
 row 4: 01101001
 */



func kThElementInGrammer(n: Int, k: Int) -> Bool {

    //Base Condition
    if n == 1 && k == 1 {
        return false
    }
    if  k > Int(truncating: pow(2, n-1) as NSNumber) {
        return false
    }
    // Induction : if k is less than mid of nth row length then. its mapped directly to above row. for eg .
    //N = 3 -> 0 1 1 0
    //N = 4 -> 0 1 1 0 - - - -
    //and rest of the item is mapped to compimentary of above row. Eg :
    //N = 3 -> 0 1 1 0
    //N = 4 -> - - - - 1 0 0 1
    let mid = Int(truncating: pow(2, n-1) / 2.0 as NSNumber)
    if k <= mid {
        // Hypothisis
        return kThElementInGrammer(n: n-1, k: k)
    } else {
        return !kThElementInGrammer(n: n-1, k: k - mid)

    }
}

print("kThElementInGrammer -- >",kThElementInGrammer(n: 4, k: 6))


// Problem :tower of Hanai
/*
 Conditions :
 1: At any point of time only one item can be picked
 2: No big Disk can be kept above a small Disk
 */

var sourceStack = Stack<Int>()
sourceStack.push(value: 20)
sourceStack.push(value: 19)
sourceStack.push(value: 18)

var destinationStack = Stack<Int>()
var helperStack = Stack<Int>()


func towerOfHanai(numberOfDisk: Int, source: Int, destination: Int, helper: Int) {
    // Base Condition :
    // If there is only one disk left then pick from source and put it on destination tower
    if numberOfDisk == 1 {
       
        print("Move Disk \(numberOfDisk) from \(source) to \(destination)")
        return
    }

    // Hypothesis : if this function works for n disks then it will work for n-1 disks as well
    towerOfHanai(numberOfDisk: numberOfDisk-1,
                 source: source,
                 destination: helper,
                 helper: destination)

    towerOfHanai(numberOfDisk: 1,
                 source: source,
                 destination: destination,
                 helper: helper)

    towerOfHanai(numberOfDisk: numberOfDisk-1,
                 source: helper,
                 destination: destination, helper: source)
}

towerOfHanai(numberOfDisk: 2, source: 1, destination: 2, helper: 3)

print("Playground execution complete")

//PS : copy an ascending stack to other stack using a helper stack in same order





var curFeeds = [3, 1, 2]

func newFeedsFetched(feeds: [Int], currentFeeds: [Int]) -> [Int] {

    var cFeeds = currentFeeds
    if currentFeeds.isEmpty {
        for value in feeds {
            cFeeds.insert(value, at: cFeeds.count)
        }
    }

    for i in 0..<feeds.count {
    // find items in array and remove
        let itemToInsert = feeds[i]
        for j in 0..<cFeeds.count {
            let itemToCompare = cFeeds[j]
            if itemToInsert == itemToCompare {
                cFeeds.remove(at: j)
                break;
            }
        }
        cFeeds.insert(feeds[i], at: i)
    }

    return cFeeds
}

print("feeds problem")
print(newFeedsFetched(feeds: [3,4,1], currentFeeds: curFeeds))


//Median of two sorted arrays of same size
// constraints -> same length array

func median(ar1:[Int], ar2:[Int], length: Int) -> Int {
    var result = -1
    if length == 1 {
        // if there are single item then return median

        guard let ar1Item = ar1.first, let ar2Item = ar2.first else { return -1 }
        return (ar1Item + ar2Item ) / 2
    }

    if ( length == 2 ) {
        return (max(ar1[0], ar2[0]) + min(ar1[1], ar2[1])) / 2
    }
    let mid: Int =  Int(ceil(Double(length/2)))
    if ( ar1[mid] < ar1[mid] ) {
        result = median(ar1: Array(ar1[mid...]), ar2: Array(ar2[0...mid]), length: mid + 1)
    } else {
        result = median(ar1: Array(ar1[0...mid]), ar2: Array(ar2[mid...]), length: mid + 1)
    }

    return result
}

//print(median(ar1: [1, 12, 15, 26, 38], ar2: [2, 13, 17, 30, 45], length: 5))



func getUniqueChar(str: String, startIndex:Int) -> Int {
    var distinct = [Character]()
    var count = 0
    for i in startIndex..<str.count {
        let item = str[i]
        if distinct.contains(item) {
            print("For string " , str, "starting", startIndex, "count", count)
            return count
        } else {
            count += 1
            distinct.append(item)
        }
    }

    print("For string " , str, "count", count)
    return count
}

func longestSubString(s: String, startIndex: Int, container: inout [Int], count: Int) -> Int {

    if startIndex == s.count {
        return count
    }

    let count = getUniqueChar(str: s, startIndex: startIndex)

    let newcount = longestSubString(s: s, startIndex: startIndex + 1, container: &container, count: count)

    return max(count, newcount)

}


var array: [Int] = []
var string = "abcabcdabc"

print("longestSubString", longestSubString(s: string, startIndex: 0, container: &array, count: 0))



class Solution {
    func lengthOfLongestSubstring(_ s: String) -> Int {
        var start: Int = 0
        var end: Int = 0
        var maxLength = -1
        var characters: Dictionary<Character, Int> = [:]

        while (end < s.count && start <= end) {
            let item =  s[end]
            if characters[item] != nil {
                let previousIndex = characters[item]
                start = max(previousIndex! + 1,start)
                characters[item] = end

            } else {
                characters[item] = end
            }

            maxLength = max(maxLength, end - start + 1)
            end += 1
        }

        print(characters)
        return maxLength
    }
}

extension StringProtocol {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
}


let s = Solution()
print("lengthOfLongestSubstring-> ",s.lengthOfLongestSubstring(string))




