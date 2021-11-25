//: [Previous](@previous)

import Foundation


var greeting = "Hello, playground"

//: [Next](@next)

class Node {
    let name: String
    init( name: String) {
        self.name = name
    }
}

// Generic Stack for equtable items
struct Stack<T:Equatable> {
    // Array to store items in memory
    var array:[T] = []
    var enableDebugging = false

    func size() -> Int {
        return array.count
    }

    mutating func push(value: T) {
        array.append(value)
        if enableDebugging { print("After push Stack = ",array) }
    }
    mutating func pop() -> T? {
        guard let value = array.last else { return nil }
        array.removeLast()
        if enableDebugging { print("After pop Stack = ",array) }
        return value
    }

    func isEmpty() -> Bool {
        return array.count == 0
    }

    func peep() -> T? {
        return array.last ?? nil
    }
}


/*

Problem:
Find longest possible itinerary given a list of departure-arrival city pairs.

[
    [HYD, BLR],
    [BLR, DEL]
]

[HYD -> BLR -> DEL]

Sample Input

[
    ["BLR", "HYD"],
    ["CHE", "MUM"],
    ["DEL", "CHE"],
    ["HYD", "KOL"],
    ["MUM", "BLR"]
]
Desired output

 ["DEL", "CHE", "MUM", "BLR", "HYD", "KOL"]

Hint: Use Adjancy Matrix

 condtions :
 - Directed graph and not cyclic

 assumption: There will be single source

*/
typealias routeType = [String]

let input = [
    ["BLR", "HYD"],
    ["CHE", "MUM"],
    ["DEL", "CHE"],
    ["HYD", "KOL"],
    ["MUM", "BLR"],
]

func findDistictNodeCount(routes: [routeType]) -> Set<String> {
    let nodes: [String] = []

    var cities: Set<String> = []
    for route in routes {
        cities.insert(route.first!)
        cities.insert(route.last!)
    }
    return cities
}

let nodeSet = findDistictNodeCount(routes: input)
var nodes: [String] = []
for node in nodeSet {
    nodes.append(node)
}

print(nodes)

var adjencyMatrixColumn = Array(repeating: 0, count: nodes.count)
var adjencyMatrix = Array(repeating: adjencyMatrixColumn, count: nodes.count)

typealias twoDIntArray = Array<Array<Int>>
func printArray(adjencyMatrix: twoDIntArray) {
    var printable = "    "
    for node in nodes  {
        printable = printable + " \(node)"
    }
    print(printable)
    printable = ""

    for i in 0..<nodes.count {
        printable = nodes[i]
        let array = adjencyMatrix[i]
        for item in array {
            printable = printable + "  \(item) "
        }
        print(printable)
    }
    print("__________________________________________ \n\n")
}

printArray(adjencyMatrix: adjencyMatrix)
func populateAdjencyMatrix(input: [[String]]) {
    for route in input {
        let source = route.first!
        let destination = route.last!

        let sourceIndex = nodes.firstIndex(of: source)!
        let destinationIndex = nodes.firstIndex(of: destination)!
        adjencyMatrix[sourceIndex][destinationIndex] = 1
    }
}

populateAdjencyMatrix(input: input)
printArray(adjencyMatrix: adjencyMatrix)

// in case there is only one  starting point
func findStartNode() -> String? {
    // node with no inbound traffic
    var source: String?
    for i in 0..<nodes.count {
        var hasInbound = false
        for j in 0..<nodes.count {
            if adjencyMatrix[j][i] == 1 {
                hasInbound = true
                break
            }
         }
        if hasInbound == false {
            source = nodes[i]
            break
        }
    }
    return source
}

// in case there are multiple starting points
func getPossibleStartNodes() -> [String] {
    // node with no inbound traffic
    var sources: [String] = []
    for i in 0..<nodes.count {
        var hasInbound = false
        for j in 0..<nodes.count {
            if adjencyMatrix[j][i] == 1 {
                hasInbound = true
                break
            }
         }
        if hasInbound == false {
            sources.append(nodes[i])
        }
    }
    print(sources)
    return sources
}

let sourceNode = findStartNode()!
let sourceNodes = getPossibleStartNodes()

// initializing visited array with blank
var visitedArray: [String: Bool] = [:]
for node in nodes {
    visitedArray[node] = false
}

func neighbours(node: String) -> [String] {
    let row = nodes.firstIndex(of: node)!
    var neighbours: [String] = []
    for i in 0..<nodes.count {
        if adjencyMatrix[row][i] == 1 {
            neighbours.append(nodes[i])
        }
    }
    return neighbours
}

var pathStack: Stack<String> = Stack()
pathStack.enableDebugging = false

func topologicalSort(matrix: twoDIntArray, souce: String) {
    visitedArray[souce] = true
    let neighbours = neighbours(node: souce)
    for node in neighbours {
        if visitedArray[node] == false {
            topologicalSort(matrix: adjencyMatrix, souce: node)
        }
    }
    pathStack.push(value: souce)
}

for source in sourceNodes {
    for node in nodes {
        visitedArray[node] = false
    }

    topologicalSort(matrix: adjencyMatrix, souce: source)


    var path: String = ""
    while(!pathStack.isEmpty()) {
        path = path + "---> \(pathStack.pop()!) "
    }
    print(path)
}


var path: String = ""
while(!pathStack.isEmpty()) {
    path = path + "---> \(pathStack.pop()!) "
}


print(path)
//must do this : topologicalSort

class Element: Hashable {
    var name: String

    init(name: String) {
        self.name = name
    }

    static func == (lhs: Element, rhs: Element) -> Bool {
        return lhs.name == rhs.name
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(name) // must be same as the values used in == operator
    }
}

let e1 = Element(name: "deepaki")
let e2 = Element(name: "deepak")

print(e1.hashValue)
print(e2.hashValue)



func naiveHash(_ string: String) -> Int {
  let unicodeScalars = string.unicodeScalars.map { Int($0.value) }
    print(unicodeScalars)
  return unicodeScalars.reduce(0, +)
}


print(naiveHash("deepak"))
//-8190957468410822061
//-4523887281802931434
