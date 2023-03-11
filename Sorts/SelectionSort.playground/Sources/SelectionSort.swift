import Foundation
//时间： O(n^2)，但比冒泡排序好，比插入排序差
//不稳定：序列5 8 5 2 9，第一遍选择第1个元素5会和2交换，那么原序列中两个5的相对前后顺序就被破坏了，所以选择排序是一个不稳定的排序算法

public func selectionSort<T: Comparable>(_ array: [T], _ isFromLowest: (T, T) -> Bool) -> [T]{
    guard array.count > 1 else { return array }
    
    var a = array
    //x只需取到倒数第二个数
    for x in 0..<a.count - 1{
        var lowest = x
        for y in x + 1 ..< a.count {
            if isFromLowest(a[y], a[lowest]){
                lowest = y
            }
        }
        
        //如果x是最小的，此时lowest = x， swap不能交换自己
        if x != lowest {
            a.swapAt(x, lowest)
        }
    }
    
    return a
}
