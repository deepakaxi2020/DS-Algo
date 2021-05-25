//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

DispatchQueue.global().sync {
    for i in 1...1000 {
        print("---", i)
    }
}




// nsoperation 

  // - sync / async

/*

DispatchQueue.global(qos: .userInteractive).async {
    for i in 1...1000 {
        print(i)
    }
}

DispatchQueue.global(qos: .background).async {
    for i in 1...1000 {
        print("statement " , i)
    }
}
 */

let array: [Int] = []
if array == nil {
    print("array is nil", array)
}
if array.isEmpty {
    print("array is empty", array)
}

if array.count == 0 {
    print("array count is 0", array)
}





//Follow the steps below to solve the problem:
//
//Initialize a boolean variable, say invert as false, to denote whether the bits in A are flipped or not.
//Initialize an empty array, say res, to store the prefix length in each operation.
//Iterate in the range [N – 1, 0] using the variable i and perform the following steps:
//If A[i] != B[i] and invert is false, then the current bit is required to be flipped. Therefore. insert (i + 1) into the array res and update invert to true.
//Otherwise, check if A[i] == B[i] and invert is true, then insert (i + 1) to res, and update invert to false.
//Print the size of the array res as the number of operations required to make the two strings equal.
//Then, print the values stored in res to denote the prefix length in each operation.

func invertString(input: String, output: String) {
    var invert = false
    var res: [Int] = []
    let inputChars = Array(input)
    let outputChars = Array(output)

    for i in (0..<inputChars.count).reversed() {
        //If A[i] != B[i] and invert is false, then the current bit is required to be flipped. Therefore. insert (i + 1) into the array res and update invert to true.
        if inputChars[i] != outputChars[i] && !invert {
            res.append(i+1)
            invert = true
        } else if inputChars[i] == outputChars[i] && invert {
            res.append(i+1)
            invert = false
        }
    }

    print("invertString , count ->",res.count)
    print("invertString , prefix ->",res)
}

invertString(input: "001", output: "000")


struct ComplexTask {
    static var firstItem: Int = 1
    static var result : Int = 0

    static func doComplexTask() -> Int {

        var array: [Int] = []
        for i in firstItem..<100 {
            array.append(i)
        }
        result = array.first!
        return result

    }
}

struct Employee {
    lazy var complexTask: Int = {
        ComplexTask.doComplexTask()
    }()
}

var obj = Employee()

print(obj.complexTask)
ComplexTask.firstItem = 100

print(obj.complexTask)


class Parent {
    func printing() {
        print("parent")
    }
}

class child: Parent {
    override func printing() {
        print("child")
    }
}


let c = child()
c.printing()


func square<T>(value: T) -> T where T: FloatingPoint {
    return value * value
}



