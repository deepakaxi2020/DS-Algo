//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

//: [Next](@next)

struct Stack<T: Equatable> {
    private var array: [T] = []

    func push(_ value: T) {


    }
}

var stack = Stack<Int>()

class Node {
    var value: String
    var previous: Node?
    var next: Node?


    init(value: String) {
        self.value = value
    }

}

func addressHeap<T: AnyObject>(o: T) -> Int {
    return unsafeBitCast(o, to: Int.self)
}

class DoublyLinkedList {

    var headNode: Node? = nil
    var tailNode: Node? = nil

    func printNodes() {
        var current = headNode
        while current != nil {
            print(current?.value ?? "no value")
            current = current?.next
        }
    }

    var isEmpty: Bool { return headNode == nil }

    func push(value: String) {
        let newNode =  Node(value: value)

        if let head = headNode {
            newNode.next = head
            head.previous = newNode
        } else {
            tailNode = newNode
        }

        headNode = newNode
    }

    func pushNode(newNode: Node) {
        if let head = headNode {
            newNode.next = head
            head.previous = newNode
        } else {
            tailNode = newNode
        }

        headNode = newNode
    }

    func deleteNode(node: Node) {
        if isEmpty { return }
        if node.next == nil && node.previous == nil { // the only node in list
            headNode = nil
            tailNode = nil
        } else if node.next == nil { // its on tail
            let previousNode = node.previous
            previousNode?.next = nil
            tailNode = previousNode
        }  else  if node.previous == nil { // its a head
            let nextNode = node.next
            nextNode?.previous = nil
            headNode = nextNode
        } else {
            let previousNode = node.previous
            let nextNode = node.next
            previousNode?.next = nextNode
            nextNode?.previous = previousNode
        }

    }

    func pop() {
        if let tail = tailNode {
            if let justBeforeTailNode = tail.previous {
                justBeforeTailNode.next = nil
                tailNode = justBeforeTailNode
            } else {
                tailNode = nil
                headNode = nil
            }
        }
    }
}



extension DoublyLinkedList: CustomStringConvertible {
    // 2
    public var description: String {
        // 3
        var text = "["
        var node = headNode
        // 4
        while node != nil {
            text += "\(node!.value)"
            node = node!.next
            if node != nil { text += ", " }
        }
        // 5
        return text + "]"
    }
}
var dll = DoublyLinkedList()
dll.push(value: "1")
dll.push(value: "2")
dll.push(value: "3")
dll.push(value: "4")
dll.push(value: "5")
dll.pop()




class LRU {

    var cap: Int = 3

    var dll: DoublyLinkedList
    var hash: [String: Node] = [:]

    var cacheCount: Int {
        hash.keys.count
    }

    init() {
        dll = DoublyLinkedList()
    }

    func setUrl(url: String, data: String) {
        if let nodeExist = hash[url] {
            dll.deleteNode(node: nodeExist)
            hash.removeValue(forKey: url)
        }


        if cacheCount == cap {
            dll.pop()
        }
        let node = Node(value: data)
        hash[url] = node
        dll.pushNode(newNode: node)

    }


    func getUrl(url: String) -> Int {

        return -1
    }

}


let cache = LRU()
cache.setUrl(url: "a", data: "a")
print(cache.dll)
cache.setUrl(url: "b", data: "b")
print(cache.dll)
cache.setUrl(url: "a", data: "a")
print(cache.dll)
cache.setUrl(url: "c", data: "c")
print(cache.dll)
cache.setUrl(url: "a", data: "a")
print(cache.dll)
cache.setUrl(url: "a", data: "a")
cache.setUrl(url: "a", data: "a")
cache.setUrl(url: "a", data: "a")
cache.setUrl(url: "a", data: "a")
cache.setUrl(url: "a", data: "a")
print(cache.dll)
