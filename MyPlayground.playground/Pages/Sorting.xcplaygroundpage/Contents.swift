//: [Previous](@previous)

import Foundation


var str = "Sorting Algorithms"

//: [Next](@next)
/*
 Selection Sort :The selection sort algorithm sorts an array by repeatedly finding the minimum element (considering ascending order) from unsorted part and putting it at the beginning. The algorithm maintains two subarrays in a given array.
 Time Complexity: O(n2) as there are two nested loops.

 Auxiliary Space: O(1)
 */

// Same array will be used by all the sorting methods below

let inputArray = [64, 25, 12, 22, 11]

func selectionSort(for input: [Int]) -> [Int]{
    var inputArray = input
    let lengthOfArray = input.count

    for i in 0..<lengthOfArray {
        var minimumIndex = i
        for j in i+1..<lengthOfArray {
            if inputArray[minimumIndex] > inputArray[j] {
                minimumIndex = j
            }
        }
        // swap minimum item with item at i index
        let minItem = inputArray[minimumIndex]
        inputArray[minimumIndex] = inputArray[i]
        inputArray[i] = minItem

    }
    return inputArray
}

print("Selection Sort",selectionSort(for: [64, 25, 12, 22, 11]))


// Bubble Sort : Bubble Sort is the simplest sorting algorithm that works by repeatedly swapping the adjacent elements if they are in wrong order.
// Time Complexity: O(n*n)
func bubbleSort(for input:[Int]) -> [Int] {
    var counter = 0
    var inputArray = input
    let lengthOfArray = input.count

    if lengthOfArray <= 1 { return inputArray }
    for j in 0..<lengthOfArray - 1  {
        for i in 1..<lengthOfArray - j   {
            counter += 1
            if inputArray[i-1] > inputArray[i] {
                let minItem = inputArray[i]
                inputArray[i] = inputArray[i-1]
                inputArray[i-1] = minItem
            }
        }
    }

    print( "execution = ",counter)
    return inputArray
}
print("Bubble Sort",bubbleSort(for: [64, 25, 12, 22, 11]))
