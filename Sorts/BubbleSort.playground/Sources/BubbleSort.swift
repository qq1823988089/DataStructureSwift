import Foundation

//时间Average: O(N^2) Worst: O(N^2)
//空间-交换:O(1)
//稳定的，不会交换相同数

public func bubbleSort<T> (_ elements: [T]) -> [T] where T: Comparable {
    return bubbleSort(elements, <)
}

public func bubbleSort<T> (_ elements: [T], _ comparison: (T,T) -> Bool) -> [T]  {
    var array = elements    
    //每一次冒泡都会确定一个数，i个数就需要i次
    for i in 0..<array.count {
        //两个两个比较，每次冒泡都能确定一个数的位置，所以最后i个数不用比较
        for j in 1..<array.count-i {
            if comparison(array[j], array[j-1]) {
                let tmp = array[j-1]
                array[j-1] = array[j]
                array[j] = tmp
            }
        }
    }
    
    return array
}

