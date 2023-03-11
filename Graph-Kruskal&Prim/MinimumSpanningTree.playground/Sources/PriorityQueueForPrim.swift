//Heap的包装
//所有操作O(lgn)
public struct PriorityQueue<T> {
    fileprivate var heap: Heap<T>
    
    //确定队列排列顺序，从大到小排列的队列使用>，从小到大的队列使用<
    public init(sort: @escaping (T, T) -> Bool) {
        heap = Heap(sort: sort)
    }
    
    public var isEmpty: Bool {
        return heap.isEmpty
    }
    
    public var count: Int {
        return heap.count
    }
    
    public func peek() -> T? {
        return heap.peek()
    }
    
    public mutating func enqueue(_ element: T) {
        heap.insert(element)
    }
    
    public mutating func dequeue() -> T? {
        return heap.remove()
    }
    
    //改变队列指定index的值
    public mutating func changePriority(index i: Int, value: T) {
        return heap.replace(index: i, value: value)
    }
}

extension PriorityQueue where T: Equatable {
    //返回指定index元素
    public func index(of element: T) -> Int? {
        return heap.index(of: element)
    }
}
