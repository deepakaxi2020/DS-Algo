//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)
//Insertion in a Binary Tree in level order



class Node {
    let value: Int
    var left: Node?
    var right: Node?
    init(with value: Int) {
        self.value = value
    }
}

/*
                10
               /  \
              11   9
              /   / \
             7   15  8

 */
var root = Node(with: 10)
root.left = Node(with: 11)
root.left?.left = Node(with: 7)
root.right = Node(with: 9)
root.right?.left = Node(with: 15)
root.right?.right = Node(with: 8)

struct Queue<T> {
    private var items = [T]()
    mutating func enqueue(value: T) {
        items.append(value)
    }

    func dequeue() -> T? {
        guard let item = items.first else { return nil }
        return item
    }
}

func heightOfBinaryTree(tree: Node?) -> Int {

    guard let node = tree else { return 0 }

    let lHeight = heightOfBinaryTree(tree: node.left)
    let rHeight = heightOfBinaryTree(tree: node.right)

    return max(lHeight,rHeight) + 1
}


func diameterOfTree(node: Node?) -> Int {

    if node == nil {
        return 0
    }

    var lDia = 0
    var rDia = 0

    if node?.left != nil {
        lDia = diameterOfTree(node: node?.left)
    }

    if node?.left != nil {
        rDia = diameterOfTree(node: node?.right)
    }

    let rootDia = lDia + rDia + 2

    return max(rootDia, max(lDia, rDia))
}



print("height of binary tree", heightOfBinaryTree(tree: root))

print("diameter of binary tree", diameterOfTree(node: root))

//Insertion in a Binary Tree in level order


func insertInBinaryTree(tree: Node?) -> Node? {


    return nil

}



//Find postorder traversal of BST from preorder traversal

func postorderTraversalOfBSTPreorder(pre: [Int]) -> [Int] {


    let count = pre.count
    if count <= 1 {
        return pre
    }
    let root = pre.first!
    //find index of larger item than root
    var firstLargestIndex = -1

    for i in 1..<count {
        if pre[i] > root {
            firstLargestIndex = i
            break
        }
    }

    let lPre = firstLargestIndex == -1 ? Array(pre[1...]) : Array(pre[1..<firstLargestIndex])
    let rPre = firstLargestIndex == -1 ? [] : Array(pre[firstLargestIndex...])

    let lPost = postorderTraversalOfBSTPreorder(pre: lPre)
    let rPost = postorderTraversalOfBSTPreorder(pre: rPre)

    var result: [Int] = []
    for item in lPost {
        result.append(item)
    }
    for item in rPost {
        result.append(item)
    }
    result.append(root)

    return result
}


print(postorderTraversalOfBSTPreorder(pre: [40, 30, 35, 80, 100])) //35 30 100 80 40


func  findPostOrderUtil( pre: [Int], n: Int,
                         minval: Int, maxval: Int,
                         preIndex: inout Int)
{

    //print("range (",minval, "- ", maxval, ")", "value at = ",preIndex)

    // If entire preorder array is traversed then
    // return as no more element is left to be
    // added to post order array.
    if preIndex == n {
        return
    }
    print("range (",minval, "- ", maxval, ")", "value at = ",pre[preIndex])
    // If array element does not lie in range specified,
    // then it is not part of current subtree.
    if pre[preIndex] < minval || pre[preIndex] > maxval {
        print("returned")
        return
    }

    // Store current value, to be printed later, after
    // printing left and right subtrees. Increment
    // preIndex to find left and right subtrees,
    // and pass this updated value to recursive calls.
    let val = pre[preIndex];
    preIndex += 1;

    // All elements with value between minval and val
    // lie in left subtree.
    findPostOrderUtil(pre: pre, n: n, minval: minval, maxval: val, preIndex: &preIndex)

    // All elements with value between val and maxval
    // lie in right subtree.
    findPostOrderUtil(pre: pre, n: n, minval: val, maxval: maxval, preIndex: &preIndex)

    print(val, " ")
}

var preIndex = 0
findPostOrderUtil(pre: [40, 30, 35, 80, 100], n: 5, minval: 0, maxval: 2000, preIndex: &preIndex)



let ar: [Int] = [1]






class MinStack {

    var stack: [Int]

    private var min = -10//Int.min
    /** initialize your data structure here. */
    init() {
        stack = []
    }

    func push(_ val: Int) {

        // empty stack condition
        if stack.count == 0 {
            min = val
            stack.append(val)
            return
        }

        if getMin() < val {
            stack.append(val)

        } else {
            let newValue = 2 * val - min
            min = val
            stack.append(newValue)
        }

    }

    func pop() {
        if stack.count == 0 { return }

        let top = stack.removeLast()

        if top < min {
            min = 2 * min - top
            print(min)
        }
    }

    func top() -> Int {
        guard let value = stack.last else  { return Int.min }

        return value
    }

    func getMin() -> Int {

        print(stack)
        return min
    }
}

/**
 * Your MinStack object will be instantiated and called as such:
 * let obj = MinStack()
 * obj.push(val)
 * obj.pop()
 * let ret_3: Int = obj.top()
 * let ret_4: Int = obj.getMin()
 */

let obj = MinStack()
obj.push(-2)
print(obj.getMin())
obj.push(0)
print(obj.getMin())
obj.push(-1)
print(obj.getMin())
obj.pop()
print(obj.getMin())



