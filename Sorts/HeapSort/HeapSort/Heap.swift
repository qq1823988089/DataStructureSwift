//
//  Heap.swift
//  HeapSort
//
//  Created by 乔一 on 2023/3/11.
//

import Foundation

public struct Heap<T> {
    
    var nodes = [T]()
    
    //>最大堆，<最小堆，自定义类型需要提供比较方法
    private var orderCriteria: (T, T) -> Bool
    
    //初始化空堆
    public init(sort: @escaping (T, T) -> Bool) {
        self.orderCriteria = sort
    }
    
    //根据array初始化堆
    public init(array: [T], sort: @escaping (T, T) -> Bool) {
        self.orderCriteria = sort
        configureHeap(from: array)
    }
    
    //从最后一个父节点向下维护堆
    //O(n)
    private mutating func configureHeap(from array: [T]) {
        nodes = array
        for i in stride(from: (nodes.count/2-1), through: 0, by: -1) {
            shiftDown(i)
        }
    }
    
    public var isEmpty: Bool {
        return nodes.isEmpty
    }
    
    public var count: Int {
        return nodes.count
    }
    
    //返回i的父节点index
    @inline(__always) internal func parentIndex(ofIndex i: Int) -> Int {
        return (i - 1) / 2
    }
    
    //返回i的左子节点index
    @inline(__always) internal func leftChildIndex(ofIndex i: Int) -> Int {
        return 2*i + 1
    }
    
    //返回i的右子节点index
    @inline(__always) internal func rightChildIndex(ofIndex i: Int) -> Int {
        return 2*i + 2
    }
    
    public func peek() -> T? {
        return nodes.first
    }
    
    //堆中插入一个节点并向上维护
    //O(logn)
    public mutating func insert(_ value: T) {
        nodes.append(value)
        shiftUp(nodes.count - 1)
    }
    
    //堆中插入一组节点
    //O(logn)
    public mutating func insert<S: Sequence>(_ sequence: S) where S.Iterator.Element == T {
        for value in sequence {
            insert(value)
        }
    }
    
    //改变堆中节点值并维护堆
    public mutating func replace(index i: Int, value: T) {
        guard i < nodes.count else { return }
        
        remove(at: i)
        insert(value)
    }
    
    //去除堆顶元素并维护堆
    @discardableResult public mutating func remove() -> T? {
        guard !nodes.isEmpty else { return nil }
        
        if nodes.count == 1 {
            return nodes.removeLast()
        } else {
            //用堆中最后一个节点补上第一个节点并向下维护
            let value = nodes[0]
            nodes[0] = nodes.removeLast()
            shiftDown(0)
            return value
        }
    }

    //去除堆中指定index元素并维护堆
    @discardableResult public mutating func remove(at index: Int) -> T? {
        guard index < nodes.count else { return nil }
        
        let size = nodes.count - 1
        //先与最后一个元素交换，再向下维护子树，最后向上维护整体
        if index != size {
            nodes.swapAt(index, size)
            shiftDown(from: index, until: size)
            shiftUp(index)
        }
        return nodes.removeLast()
    }
    
    //向上维护
    internal mutating func shiftUp(_ index: Int) {
        var childIndex = index
        let child = nodes[childIndex]
        var parentIndex = self.parentIndex(ofIndex: childIndex)
        
        //与父节点比较
        while childIndex > 0 && orderCriteria(child, nodes[parentIndex]) {
            //更新node的值
            nodes[childIndex] = nodes[parentIndex]
            //更新index
            childIndex = parentIndex
            parentIndex = self.parentIndex(ofIndex: childIndex)
        }
        
        nodes[childIndex] = child
    }
    
    //向下维护
    internal mutating func shiftDown(from index: Int, until endIndex: Int) {
        let leftChildIndex = self.leftChildIndex(ofIndex: index)
        let rightChildIndex = leftChildIndex + 1
        
        var first = index
        if leftChildIndex < endIndex && orderCriteria(nodes[leftChildIndex], nodes[first]) {
            first = leftChildIndex
        }
        if rightChildIndex < endIndex && orderCriteria(nodes[rightChildIndex], nodes[first]) {
            first = rightChildIndex
        }
        //如果index与左右子位置正确则无需维护
        if first == index { return }
        
        nodes.swapAt(index, first)
        shiftDown(from: first, until: endIndex)
    }
    
    internal mutating func shiftDown(_ index: Int) {
        shiftDown(from: index, until: nodes.count)
    }
    
}

// MARK: - Searching

extension Heap where T: Equatable {
    //返回指定节点index
    //O(n)
    public func index(of node: T) -> Int? {
        return nodes.firstIndex(where: { $0 == node })
    }
    
    //去除node
    //O(n)
    @discardableResult public mutating func remove(node: T) -> T? {
        if let index = index(of: node) {
            return remove(at: index)
        }
        return nil
    }
    
}
