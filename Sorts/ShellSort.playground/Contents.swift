//时间：最坏情况O(n^2)，增量间隔不互质，只有1增量起作用；运气好O(nlogn)
//不稳定：如果有一个数组 [2, 1, 2a, 3, 2b]，其中2a和2b表示两个相等的元素。在进行希尔排序时，如果先将间隔设为2，那么数组会被分成两个子序列 [2, 2a, 2b] 和 [1, 3]。在对这两个子序列进行插入排序时，2a和2b都会与3比较，2a和2b的相对位置可能会发生改变。如果先将间隔设为1，在进行插入排序时，2a和2b的相对位置不会改变
public func insertionSort(_ list: inout [Int], start: Int, gap: Int) {
    for i in stride(from: (start + gap), to: list.count, by: gap) {
        let currentValue = list[i]
        var pos = i
        //pos到start位置或pos数>=前一个数终止循环
        while pos >= gap && list[pos - gap] > currentValue {
            list[pos] = list[pos - gap]
            pos -= gap
        }
        list[pos] = currentValue
    }
}

public func shellSort(_ list: inout [Int]) {
    var sublistCount = list.count / 2
    while sublistCount > 0 {
        for pos in 0..<sublistCount {
            insertionSort(&list, start: pos, gap: sublistCount)
        }
        sublistCount = sublistCount / 2
    }
}

var arr = [64, 20, 50, 33, 72, 10, 23, -1, 4, 5]

shellSort(&arr)
