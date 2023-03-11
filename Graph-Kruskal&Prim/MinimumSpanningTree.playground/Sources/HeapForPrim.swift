public struct Heap<T> {
    var elements = [T]()
    
    //确定是最大堆还是最小堆
    fileprivate var isOrderedBefore: (T, T) -> Bool
    
    //创建一个空堆，sort是>代表最大堆，<代表最小堆
    public init(sort: @escaping (T, T) -> Bool) {
        self.isOrderedBefore = sort
    }
    
    //根据指定array和sort创建一个空堆
    public init(array: [T], sort: @escaping (T, T) -> Bool) {
        self.isOrderedBefore = sort
        buildHeap(fromArray: array)
    }
    
    //O(nlogn)
    /*
    private mutating func buildHeap(array: [T]) {
        elements.reserveCapacity(array.count)
        for value in array {
            insert(value)
        }
    }
     */
    
    //根据指定array构建最大堆或最小堆
    //O(n)
    fileprivate mutating func buildHeap(fromArray array: [T]) {
        elements = array
        for i in stride(from: (elements.count/2 - 1), through: 0, by: -1) {
            shiftDown(i, heapSize: elements.count)
        }
    }
    
    public var isEmpty: Bool {
        return elements.isEmpty
    }
    
    public var count: Int {
        return elements.count
    }
    
    //内联展开将函数体的代码插入到调用该函数的地方，以避免函数调用的开销，由于这个函数的代码非常简单，内联展开可以提高代码的性能
    //返回i父节点的下标
    @inline(__always) func parentIndex(ofIndex i: Int) -> Int {
        return (i - 1) / 2
    }
    
    //返回i左子节点的下标
    @inline(__always) func leftChildIndex(ofIndex i: Int) -> Int {
        return 2*i + 1
    }
    
    //返回i右子节点的下标
    @inline(__always) func rightChildIndex(ofIndex i: Int) -> Int {
        return 2*i + 2
    }
    
    //返回堆顶元素
    public func peek() -> T? {
        return elements.first
    }
    
    //堆中加入新节点，需要重新调整整个堆以保持最大堆或最小堆，O(logn)
    public mutating func insert(_ value: T) {
        elements.append(value)
        shiftUp(elements.count - 1)
    }
    
    //堆中插入一组节点
    //它sequence参数可以是任意遵循Sequence协议的类型。S.Iterator.Element表示S类型的元素类型，即sequence中元素的类型，它必须与堆中元素的类型相同（即T类型）
    public mutating func insert<S: Sequence>(_ sequence: S) where S.Iterator.Element == T {
        for value in sequence {
            insert(value)
        }
    }
    
    //改变节点的值
    public mutating func replace(index i: Int, value: T) {
        guard i < elements.count else { return }
        //最大堆改变值需要比原先大，最小堆需要比原先小
        assert(isOrderedBefore(value, elements[i]))
        elements[i] = value
        shiftUp(i)
    }
    
    //去除堆顶元素
    @discardableResult public mutating func remove() -> T? {
        if elements.isEmpty {
            return nil
        } else if elements.count == 1 {
            return elements.removeLast()
        } else {
            //去除后用最后一个节点代替堆顶元素并向下调整
            let value = elements[0]
            elements[0] = elements.removeLast()
            shiftDown()
            return value
        }
    }
    
    //去除指定index节点O(logn)，找到指定节点的index需要O(n)
    public mutating func removeAt(_ index: Int) -> T? {
        guard index < elements.count else { return nil }
        
        let size = elements.count - 1
        if index != size {
            elements.swapAt(index,size)
            shiftDown(index, heapSize: size)
            shiftUp(index)
        }
        return elements.removeLast()
    }
    
    //向上调整
    mutating func shiftUp(_ index: Int) {
        var childIndex = index
        let child = elements[childIndex]
        var parentIndex = self.parentIndex(ofIndex: childIndex)
        
        while childIndex > 0 && isOrderedBefore(child, elements[parentIndex]) {
            elements[childIndex] = elements[parentIndex]
            childIndex = parentIndex
            parentIndex = self.parentIndex(ofIndex: childIndex)
        }
        
        elements[childIndex] = child
    }
    
    //向下调整
    mutating func shiftDown() {
        shiftDown(0, heapSize: elements.count)
    }
    
    mutating func shiftDown(_ index: Int, heapSize: Int) {
        var parentIndex = index
        
        while true {
            let leftChildIndex = self.leftChildIndex(ofIndex: parentIndex)
            let rightChildIndex = leftChildIndex + 1
            
            //确定与左孩子还是右孩子交换或是无需交换
            var first = parentIndex
            if leftChildIndex < heapSize && isOrderedBefore(elements[leftChildIndex], elements[first]) {
                first = leftChildIndex
            }
            if rightChildIndex < heapSize && isOrderedBefore(elements[rightChildIndex], elements[first]) {
                first = rightChildIndex
            }
            if first == parentIndex { return }
            
            elements.swapAt(parentIndex,first)
            //更新parentIndex
            parentIndex = first
        }
    }
}

// MARK: - Searching
extension Heap where T: Equatable {
    //在堆中寻找指定index元素，O(n)
    public func index(of element: T) -> Int? {
        //从第一个元素开始找
        return index(of: element, 0)
    }
    
    fileprivate func index(of element: T, _ i: Int) -> Int? {
        //未找到
        if i >= count { return nil }
        //比最大堆堆顶元素大或比最小堆堆顶元素小
        if isOrderedBefore(element, elements[i]) { return nil }
        //找到了
        if element == elements[i] { return i }
        //i不是要找的节点，从i的左右子节点递归查找
        if let j = index(of: element, self.leftChildIndex(ofIndex: i)) { return j }
        if let j = index(of: element, self.rightChildIndex(ofIndex: i)) { return j }
        return nil
    }
}
