//
//  InsertionSort.swift
//  
//
//  Created by 乔一 on 2023/3/11.
//

import Foundation

//时间：O(N^2)
//在数较少时可以用
public func insertionSort<T>(_ array: [T], _ isOrderedBefore: (T, T) -> Bool) -> [T] {
    guard array.count > 1 else { return array }
    //函数参数为常量，函数体只能访问不能修改，这里复制一份
    var sortedArray = array
    //从第二个数开始
    for index in 1..<sortedArray.count {
        var currentIndex = index
        //记录当前数
        let temp = sortedArray[currentIndex]
        //与前一个数比较，符合要求则赋值给当前数直到找到插入位置
        while currentIndex > 0, isOrderedBefore(temp, sortedArray[currentIndex - 1]) {
            sortedArray[currentIndex] = sortedArray[currentIndex - 1]
            currentIndex -= 1
        }
        sortedArray[currentIndex] = temp
    }
    return sortedArray
}
