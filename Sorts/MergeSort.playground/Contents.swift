//归并排序时间：O(nlogn)
//稳定：对于相等的元素，先将左边的元素放入结果数组中，这样就保证了相等元素的相对位置不会发生变化

//递归
//分成单位为1的有序数组
func mergeSort<T: Comparable>(_ array: [T]) -> [T] {
    guard array.count > 1 else { return array }
    let middleIndex = array.count / 2
    let leftArray = mergeSort(Array(array[0..<middleIndex]))
    let rightArray = mergeSort(Array(array[middleIndex..<array.count]))
    return merge(leftPile: leftArray, rightPile: rightArray)
}

//合并
func merge<T: Comparable>(leftPile: [T], rightPile: [T]) -> [T] {
    var leftIndex = 0
    var rightIndex = 0
    var orderedPile = [T]()
    if orderedPile.capacity < leftPile.count + rightPile.count {
        orderedPile.reserveCapacity(leftPile.count + rightPile.count)
    }
    
    while true {
        //当一个子序列为空，另一个不为空时，将另一个全部加入结果序列
        guard leftIndex < leftPile.endIndex else {
            orderedPile.append(contentsOf: rightPile[rightIndex..<rightPile.endIndex])
            break
        }
        guard rightIndex < rightPile.endIndex else {
            orderedPile.append(contentsOf: leftPile[leftIndex..<leftPile.endIndex])
            break
        }
        //左右数组中选小的加入结果数组，并指向下一个数
        if leftPile[leftIndex] < rightPile[rightIndex] {
            orderedPile.append(leftPile[leftIndex])
            leftIndex += 1
        } else {
            orderedPile.append(rightPile[rightIndex])
            rightIndex += 1
        }
    }
    return orderedPile
}

let array = [2, 1, 5, 4, 9]
let sortedArray = mergeSort(array)
let array2 = ["Tom", "Harry", "Ron", "Chandler", "Monica"]
let sortedArray2 = mergeSort(array2)

//迭代
func mergeSortBottomUp<T>(_ a: [T], _ isOrderedBefore: (T, T) -> Bool) -> [T] {
    let n = a.count
    //一个原数组，一个辅助数组，
    var z = [a, a]
    //控制哪个数组是辅助数组，d是原数组，1-d是辅助数组，辅助数组中写入正确结果
    var d = 0
    //子序列宽度，初始为1
    var width = 1
    
    while width < n {
        var i = 0
        while i < n {
            //辅助数组起始
            var j = i
            //左子序列起始
            var l = i
            //右子序列起始
            var r = i + width
            //左子序列末尾
            let lmax = min(l + width, n)
            //右子序列末尾
            let rmax = min(r + width, n)
            
            while l < lmax && r < rmax {
                //比较左右子序列，将符合的写入辅助数组
                if isOrderedBefore(z[d][l], z[d][r]) {
                    z[1 - d][j] = z[d][l]
                    l += 1
                } else {
                    z[1 - d][j] = z[d][r]
                    r += 1
                }
                j += 1
            }
            //如果一个数组为空，另一个不为空，则将另一个全部写入辅助数组
            while l < lmax {
                z[1 - d][j] = z[d][l]
                j += 1
                l += 1
            }
            while r < rmax {
                z[1 - d][j] = z[d][r]
                j += 1
                r += 1
            }
            //更新下一对比较的左右子序列的开始
            i += width*2
        }
        //一轮结束，更新左右子序列长度
        width *= 2
        //交换辅助数组与原数组
        d = 1 - d
    }
    
    return z[d]
}

mergeSortBottomUp(array, <)
