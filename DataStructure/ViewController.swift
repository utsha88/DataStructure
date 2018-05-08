//
//  ViewController.swift
//  DataStructure
//
//  Created by Utsha Guha on 26-4-18.
//  Copyright © 2018 Utsha Guha. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        /************** TREE *********************/
        let nodeObject:Node = Node(value:"Food")
        
        let childNode1 = Node(value:"Vegan")
        childNode1.addChild(child: Node(value:"Tofu"))
        childNode1.addChild(child: Node(value:"Spinach"))
        
        let childNode2 = Node(value:"Non Veg")
        let childNode3 = Node(value:"Chicken")
        childNode2.addChild(child: childNode3)
        childNode2.addChild(child: Node(value:"Beef"))
        
        childNode3.addChild(child: Node(value:"Wings"))
        childNode3.addChild(child: Node(value:"Drumsticks"))
        
        nodeObject.addChild(child: childNode1)
        nodeObject.addChild(child: childNode2)
        
        let treeResult = nodeObject.getDescription(node: nodeObject)
        print("final result = \(treeResult)")
        /************** TREE *********************/
        
        /************** STACK *********************/
        let stackObject:Stack = Stack(value:[11,19,9,12])
        let stackObject2:Stack = Stack(value:["abc","ffd","dfs","aef"])
        stackObject.push(value: 13)
        stackObject.push(value: 31)
        stackObject2.push(value: "ssd")
        let stResult = stackObject.pop()
        let stResult2 = stackObject2.pop()
        print(stResult)
        print(stResult2)
        
        /************** STACK *********************/
        
        /************** MERGE SORT *********************/
        let mergeObject:MergeSort = MergeSort()
        let mergedArray = mergeObject.mergeSort(input: [2,32,13,23,45,5,7])
        print(mergedArray)
        /************** MERGE SORT *********************/
        
        /************** BINARY SEARCH *********************/
        let binarySearch:BinarySearch = BinarySearch()
        let binIndex = binarySearch.binarySearch(input: [5,8,12,14,45,67,98,102,120], searchItem: 14)
        print(binIndex)
        /************** BINARY SEARCH *********************/
        
        /************** Linked List *********************/
        let llObj:LLNode = LLNode()
        llObj.append(nodeValue: "abc")
        llObj.append(nodeValue: "def")
        llObj.append(nodeValue: "ghi")
        llObj.append(nodeValue: "jkl")
        let llResult = llObj.description(node: llObj.head!)
        print("Linked List = \(llResult)")
        /************** Linked List *********************/
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

/************** TREE *********************/
class Node {

    var value:String?
    var children:[Node] = []
    var parent:Node?
    var childArray:[String] = []
    
    init(value:String) {
        self.value = value
    }
    
    func isLeaf(node:Node) -> Bool {
        if node.children.count == 0 {
            return true
        }
        return false
    }
    
    func addChild(child:Node) {
        children.append(child)
        child.parent = self
    }
    
    func getDescription(node:Node) -> String {
        let arr = node.children.map{$0.value!}
        var str = arr.joined(separator: ",")
        
        var tmpStr:String = ""
        for n in node.children{
            if !self.isLeaf(node: n) {
                tmpStr = self.getDescription(node: n)
                str = str.replacingOccurrences(of: n.value!, with: tmpStr)
            }
        }

        return node.value! + ":{" + str + "}"

    }
    
}
/************** TREE *********************/

/************** STACK *********************/
class Stack<T> {
    var stackArray:[T]?
    
    init(value:[T]) {
        self.stackArray = value
    }
    
    func push(value:T) {
        stackArray?.append(value)
    }
    
    func pop() -> [T] {
        stackArray?.remove(at: 0)
        return stackArray!
    }
    
}
/************** STACK *********************/

/************** MERGE SORT *********************/
class MergeSort {
    func mergeSort(input:[Int]) -> [Int] {
        if input.count == 1 {
            return input
        }
        let middleIndex = input.count/2
        let leftArray = self.mergeSort(input: Array(input[0..<middleIndex]))
        let rightArray = self.mergeSort(input: Array(input[middleIndex..<input.count]))
        let orderedArray = self.merge(left: leftArray, right: rightArray)
        return orderedArray
    }
    
    func merge(left:[Int], right:[Int]) -> [Int] {
        var leftIndex = 0
        var rightIndex = 0
        var orderedArray: [Int] = []
        
        while left.count>leftIndex && right.count>rightIndex {
            let leftElement = left[leftIndex]
            let rightElement = right[rightIndex]
            
            if leftElement<rightElement {
                orderedArray.append(leftElement)
                leftIndex += 1
            }
            else if leftElement>rightElement {
                orderedArray.append(rightElement)
                rightIndex += 1
            }
            else{
                orderedArray.append(leftElement)
                leftIndex += 1
                orderedArray.append(rightElement)
                rightIndex += 1
            }
        }
        
        while left.count>leftIndex {
            orderedArray.append(left[leftIndex])
            leftIndex += 1
        }
        
        while right.count>rightIndex {
            orderedArray.append(right[rightIndex])
            rightIndex += 1
        }
        
        return orderedArray
    }
}

/************** MERGE SORT *********************/

/************** BINARY SEARCH *********************/
class BinarySearch {
    // [5,8,12,14,45,67,98,102,120]
    func binarySearch(input:[Int], searchItem:Int) -> Int {
        var lowIndex = 0
        var highIndex = input.count
        let midIndex = (highIndex+lowIndex)/2
        
        if input[midIndex]>searchItem {
            highIndex = midIndex
        }
        else if input[midIndex]<searchItem {
            lowIndex = midIndex
        }
        else if input[midIndex] == searchItem {
            return midIndex
        }
        
        let myIndex = self.binarySearch(input: Array(input[lowIndex..<highIndex]), searchItem: searchItem)
        return myIndex
    }
}
/************** BINARY SEARCH *********************/

/************** Linked List *********************/
class LLNode {
    var llDescription:String = ""
    var llArray:[String] = []
    var value:String?
    var head:LLNode?
    var tail:LLNode?
    
    var next:LLNode?
    var prev:LLNode?
    
    init() {
        
    }
    
    init(value:String) {
        self.value = value
    }
    
    func append(nodeValue:String) {
        let newNode = LLNode(value:nodeValue)
        
        if let tailNode = tail {
            newNode.prev = tailNode
            tailNode.next = newNode
        }
        else{
            head = newNode
        }
        tail = newNode
    }
    
    func description(node:LLNode) -> String {
        var newNode = node
        if (node.prev == nil) {
            llArray.append(node.value!)
        }

        while (newNode.next != nil) {
            llArray.append((newNode.next?.value)!)
            newNode = newNode.next!
        }
        llDescription = llArray.joined(separator: " -> ")
        return llDescription
    }
}
/************** Linked List *********************/

