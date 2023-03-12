import Foundation
//时间：在最坏的情况下，快速排序的时间复杂度为 O(n^2)，但在平均情况下，时间复杂度为 O(nlogn)
//原地排序且不稳定

//递归
func quicksort<T: Comparable>(_ a: [T]) -> [T] {
    guard a.count > 1 else { return a }
    
    let pivot = a[a.count/2]
    let less = a.filter { $0 < pivot }
    let equal = a.filter { $0 == pivot }
    let greater = a.filter { $0 > pivot }
    
    return quicksort(less) + equal + quicksort(greater)
}

let list1 = [ 10, 0, 3, 9, 2, 14, 8, 27, 1, 5, 8, -1, 26 ]
quicksort(list1)

//选最后一个元素为pivot，并从首位放置比pivot小的数，忽略比pivot大的数
func partitionLomuto<T: Comparable>(_ a: inout [T], low: Int, high: Int) -> Int {
    let pivot = a[high]
    //i初始在首位
    var i = low
    //遍历数组，把比pivot小的数从首位开始放置
    for j in low..<high {
        if a[j] <= pivot {
            a.swapAt(i, j)
            i += 1
        }
    }
    //遍历结束后，i会在最后一个比pivot小的数后面，此时与pivot交换完成partition
    a.swapAt(i, high)
    return i
}

var list2 = [ 10, 0, 3, 9, 2, 14, 26, 27, 1, 5, 8, -1, 8 ]
partitionLomuto(&list2, low: 0, high: list2.count - 1)
list2

func quicksortLomuto<T: Comparable>(_ a: inout [T], low: Int, high: Int) {
    if low < high {
        let p = partitionLomuto(&a, low: low, high: high)
        quicksortLomuto(&a, low: low, high: p - 1)
        quicksortLomuto(&a, low: p + 1, high: high)
    }
}

quicksortLomuto(&list2, low: 0, high: list2.count - 1)

//选第一个元素为pivot，分别从数组首末开始搜索，都找到不符合位置的数时互相交换
func partitionHoare<T: Comparable>(_ a: inout [T], low: Int, high: Int) -> Int {
    let pivot = a[low]
    //i初始化为第一元素的前一个
    var i = low - 1
    //j初始化为最后一个元素的后一个
    var j = high + 1
    
    while true {
        //从后往前搜索比pivot小的数
        repeat { j -= 1 } while a[j] > pivot
        //从前往后搜索比pivot大的数
        repeat { i += 1 } while a[i] < pivot
        //都找到后分别交换，i>=j时代表遍历完成
        if i < j {
            a.swapAt(i, j)
        } else {
            //不能返回i，i最后会在右子数组的第一个,0-i就包含了比pivot大的元素
            //而j在左子数组的第一个，0-j正好是比pivot小的元素
            return j
        }
    }
}

var list3 = [ 8, 0, 3, 9, 2, 14, 10, 27, 1, 5, 8, -1, 26 ]
partitionHoare(&list3, low: 0, high: list3.count - 1)
list3

func quicksortHoare<T: Comparable>(_ a: inout [T], low: Int, high: Int) {
    if low < high {
        //此时p仅代表jie shu
        let p = partitionHoare(&a, low: low, high: high)
        quicksortHoare(&a, low: low, high: p)
        quicksortHoare(&a, low: p + 1, high: high)
    }
}

quicksortHoare(&list3, low: 0, high: list3.count - 1)

//随机选择pivot
public func random(min: Int, max: Int) -> Int {
    assert(min < max)
    return min + Int(arc4random_uniform(UInt32(max - min + 1)))
}

func quicksortRandom<T: Comparable>(_ a: inout [T], low: Int, high: Int) {
    if low < high {
        let pivotIndex = random(min: low, max: high)
        //把pivot与最后一个元素交换
        (a[pivotIndex], a[high]) = (a[high], a[pivotIndex])
        
        let p = partitionLomuto(&a, low: low, high: high)
        quicksortRandom(&a, low: low, high: p - 1)
        quicksortRandom(&a, low: p + 1, high: high)
    }
}

var list4 = [ 10, 0, 3, 9, 2, 14, 8, 27, 1, 5, 8, -1, 26 ]
quicksortRandom(&list4, low: 0, high: list4.count - 1)
list4

//选定一个pivot，并且与pivot相等的数会在中间，将数组分为了三段
//swapat不能在交换相同位置的数
public func swap<T>(_ a: inout [T], _ i: Int, _ j: Int) {
    if i != j {
        a.swapAt(i, j)
    }
}

func partitionDutchFlag<T: Comparable>(_ a: inout [T], low: Int, high: Int, pivotIndex: Int) -> (Int, Int) {
    let pivot = a[pivotIndex]
    
    var smaller = low
    var equal = low
    var larger = high
    //larger指向的是右子数组的前一个，所以euqal大于larger才代表循环完成
    while equal <= larger {
        //因为equal是从smaller开始的，放置比pivot小的数equal需要加1，而比equal大的数只要larger-1
        //equal从low开始寻找比pivot小的数，找到后smaller上的数交换并+1，完成一个比pivot小的数的放置
        if a[equal] < pivot {
            swap(&a, smaller, equal)
            smaller += 1
            equal += 1
        //与equal相等的数则+1
        } else if a[equal] == pivot {
            equal += 1
        } else {
        //比equal大的数则与larger上的数交换并larger-1，equal位置不变
            swap(&a, equal, larger)
            larger -= 1
        }
    }
    return (smaller, larger)
}

var list5 = [ 10, 0, 3, 9, 2, 14, 8, 27, 1, 5, 8, -1, 26 ]
partitionDutchFlag(&list5, low: 0, high: list5.count - 1, pivotIndex: 10)
list5

func quicksortDutchFlag<T: Comparable>(_ a: inout [T], low: Int, high: Int) {
    if low < high {
        let pivotIndex = random(min: low, max: high)
        let (p, q) = partitionDutchFlag(&a, low: low, high: high, pivotIndex: pivotIndex)
        //larger指向的是右子数组的前一个，smaller指向的是左子数组的后一个，所以p-q是equal的数
        quicksortDutchFlag(&a, low: low, high: p - 1)
        quicksortDutchFlag(&a, low: q + 1, high: high)
    }
}

quicksortDutchFlag(&list5, low: 0, high: list5.count - 1)

