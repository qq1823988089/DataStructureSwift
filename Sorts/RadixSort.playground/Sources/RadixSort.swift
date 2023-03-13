import Foundation

//时间：0(P(N+B)),其中P代表排序次数也就是数的最大位数，N代表数的个数，B代表桶的个数，当B或N相差非常大时，时间复杂度是线性的
//稳定：在排序过程中，只是将数字依次放入桶中，不会改变相同元素的相对位置
//按每个数的个、十、百位大小分三次放入桶中分别排序
public func radixSort(_ array: inout [Int]){
    //基数为10
    let radix = 10
    var done = false
    //个位数or十位数or百位数
    var index: Int
    //初始求个位数
    var digit = 1
    
    while !done{
        done = true
        //初始化桶
        var buckets: [[Int]] = []
        for _ in 1...radix{
            buckets.append([])
        }
        
        for number in array{
            index = number / digit
            //根据第i位数的大小放入桶中
            buckets[index % radix].append(number)
            //如果有所有数的index=0表明处理完成
            if done && index > 0{
                done = false
            }
        }
        
        //第一次排序结果
        var i = 0
        for j in 0..<radix {
            let bucket = buckets[j]
            for number in bucket {
                array[i] = number
                i += 1
            }
        }
        
        //开始下一轮排序
        digit *= radix
    }
}
