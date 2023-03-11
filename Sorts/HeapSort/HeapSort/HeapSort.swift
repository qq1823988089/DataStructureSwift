//
//  HeapSort.swift
//  HeapSort
//
//  Created by 乔一 on 2023/3/11.
//

import Foundation
//从最后一个元素开始，从小到排序则使用最大堆，使堆顶元素与最后一个元素交换，维护后规模减1并继续知道倒数第二个元素
//时间：任何情况O(nlogn)
//不稳定：[9, 8, 5, 5, 3, 1, 2, 5]->[5, 8, 5, 5, 3, 1, 2, 9]
extension Heap {
    public mutating func sort() -> [T]{
        //到倒数第二个元素为止
        for i in stride(from: nodes.count - 1, through: 1, by: -1){
            nodes.swapAt(0, i)
            shiftDown(from: 0, until: i)
        }
        return nodes
    }
}

//如果从小到大排列传入<，需要最大堆，堆需要传入>
public func heapsort<T>(_ a: [T], _ sort: @escaping (T, T) -> Bool) -> [T] {
    let reverseOrder = { i1, i2 in sort(i2, i1) }
    //Heap在函数结束后继续存在，继续持有闭包
    var h = Heap(array: a, sort: reverseOrder)
    return h.sort()
}
