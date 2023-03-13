var array: [Int] = [19, 4242, 2, 9, 912, 101, 55, 67, 89, 32]
radixSort(&array)

//range函数创建0-999的数组
var bigArray = (0..<1000).map { _ in Int.random(in: 1...1000) }
bigArray
radixSort(&bigArray)
