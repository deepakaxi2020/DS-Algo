//: [Previous](@previous)

import Foundation


var str = "Sorting Algorithms"

//: [Next](@next)
/*
 Selection Sort :The selection sort algorithm sorts an array by repeatedly finding the minimum element (considering ascending order) from unsorted part and putting it at the beginning. The algorithm maintains two subarrays in a given array.
 Time Complexity: O(n2) as there are two nested loops.

 Auxiliary Space: O(1)
 */

func selectionSort(for input: [Int]) -> [Int]{
    var inputArray = input
    var lengthOfArray = input.count
    for i in 0..<lengthOfArray {
        var minimumIndex = i

        for j in i+1..<lengthOfArray {
            if inputArray[minimumIndex] > inputArray[j] {
                minimumIndex = j
            }
        }
        // swap minimum item with item at i index
        var minItem = inputArray[minimumIndex]
        inputArray[minimumIndex] = inputArray[i]
        inputArray[i] = minItem

    }
    return inputArray
}

print("Selection Sort",selectionSort(for: [64, 25, 12, 22, 11]))
