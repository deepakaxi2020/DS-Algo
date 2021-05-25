//: [Previous](@previous)

import Foundation
import UIKit

var str = "Hello, playground"

//: [Next](@next)


class singletonStruct {
    static let shared: singletonStruct = singletonStruct()

    private init() { }
}


//print(singletonStruct.shared)
//
//print(ObjectIdentifier(singletonStruct.shared))
//
//print(singletonStruct.shared)
//
//print(ObjectIdentifier(singletonStruct.shared))
//

/*DispatchQueue.main.async {
    for _ in 0...100 {
        print("❤️")
    }
}
*/
//DispatchQueue.global().async {
//    DispatchQueue.main.async {
//        for _ in 0...100 {
//            print("❤️")
//        }
//    }
//    for _ in 0...100 {
//        print("😩")
//
//
//    }
//}
//
//DispatchQueue.global().async {
//    DispatchQueue.main.async {
//        for _ in 0...100 {
//            print("😒")
//        }
//    }
//    for _ in 0...100 {
//        print("🤓")
//
//
//    }
//}
//
//
//
//
//
//class ABC {
//    private var variable:Int = 1
//    var writeInProgress = false
//
//    let queue = DispatchQueue(label: "accessQueue")
//
//    var dispatchGroup = DispatchGroup()
//
//    func read() -> Int? {
//        var value: Int?
//        queue.sync {
//
//            value = self.variable
//        }
//        return value
//    }
//
//    func  write(value: Int) {
//        queue.async(group: nil, qos: .default, flags: .barrier) {
//            self.variable = value
//        }
//
//    }
//}
//
//
//
//// Pre-order
//
//// in-order
//
//
//
//protocol Trackable {
//    associatedtype type
//    func doSomehthing() -> type
//}
//
//class Track: Trackable {
//    typealias type = Int
//
//    func doSomehthing() -> Int {
//        return 1
//    }
//}
//


class Node {
    let value: String
    var left: Node?
    var right: Node?
    init(with value: String) {
        self.value = value
    }
}

class Tree {
    var root: Node

    init(withRoot root: Node) {
        self.root = root
    }
}


let myTree = Tree(withRoot: Node(with: "A"))

myTree.root.left = Node(with: "B")
myTree.root.right = Node(with: "C")

myTree.root.left?.left = Node(with: "D")
myTree.root.left?.right = Node(with: "E")

myTree.root.right?.left = Node(with: "F")
myTree.root.right?.right = Node(with: "G")


var inOrderArray:[String] = []
var preOrderArray:[String] = []

func inOrderTraversal(tree: Tree, root: Node) {


    guard let leftNode = root.left else {
        inOrderArray.append(root.value)
        return
    }
    inOrderTraversal(tree: tree, root: leftNode)

    inOrderArray.append(root.value)

    guard let rightNode = root.right else {
        inOrderArray.append(root.value)
        return
    }
    inOrderTraversal(tree: tree, root: rightNode)
}

inOrderTraversal(tree: myTree, root: myTree.root)
print("InOrder = ",inOrderArray)


func preOrderTraveral(tree: Tree, root: Node) {

    preOrderArray.append(root.value)

    guard let leftNode = root.left else {
        return
    }
    preOrderTraveral(tree: tree, root: leftNode)


    guard let rightNode = root.right else {
        return
    }
    preOrderTraveral(tree: tree, root: rightNode)
}


preOrderTraveral(tree: myTree, root: myTree.root)
print("Preorder = ", preOrderArray)

var answerTree: Tree = Tree(withRoot: Node(with: preOrderArray.first ?? "A"))


var preIndex: Int = 0

func makeTree(ino: [String], pre:[String], start: Int, end: Int) -> Node? {


    print("calling for = \(ino) , \(pre) , \(start), \(end) \(preIndex)")
    if start > end {
        return nil
    }



    let rootNode = Node(with: pre[preIndex])
    preIndex += 1
    if start == end {
        return rootNode
    }

    let rootIndex = ino.firstIndex(of: rootNode.value)!

    rootNode.left = makeTree(ino: ino, pre: pre, start: start, end: rootIndex - 1)
    rootNode.right = makeTree(ino: ino, pre: pre, start: rootIndex + 1, end: end)

    return rootNode
}


// time Complexity  : O(n)
let root = makeTree(ino: inOrderArray, pre: preOrderArray, start: 0, end: inOrderArray.count - 1 )

let ansTree = Tree(withRoot: root!)
inOrderArray.removeAll()
inOrderTraversal(tree: ansTree, root: ansTree.root)
print(inOrderArray)


protocol FullyNamed {
    var fullName: String { get set }
}
struct Detective: FullyNamed {
    //Error message: Type 'Detective' does not conform to protocol //'FullyNamed'
    var fullName: String
}

fileprivate extension Detective {

}
let Rorschach = Detective(fullName: "Walter Joseph Kovacs")



struct AccessModifier {
    let a: Int
    private let b: Int
    fileprivate let c: Int
    public let d: Int
    public let e: Int
}

