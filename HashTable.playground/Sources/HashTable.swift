/*
 哈希表（Hash Table）：一种通用的键值对符号表。
 键必须是“可哈希的”（Hashable），这意味着它可以被转换成一个相当独特的整数值。哈希值越唯一，越好。
 哈希表使用一个内部桶数组来存储键值对。哈希表的容量由桶的数量确定。此实现具有固定容量——它不会在插入更多键值对时调整数组大小。
 要插入或查找特定的键值对，哈希函数将键转换为数组索引。理想的哈希函数应保证不同的键映射到不同的索引。
 由于不同的键可能映射到相同的数组索引，所有哈希表都实现了冲突解决策略。此实现使用一种称为“分离链接”的策略，其中哈希到同一索引的键值对在一个列表中“链接在一起”。为了获得良好的性能，哈希表的容量应该足够大，以使列表很小。
 大小适当的哈希表平均性能非常好。然而，在最坏情况下，所有键都映射到同一个桶时需要遍历需要O(n)时间的列表。
 
       平均      最差
空间:   O(n)     O(n)
查:     O(1)     O(n)
插入:   O(1)     O(n)
删:     O(1)     O(n)
 */

public struct HashTable<Key: Hashable, Value> {
    //bucket[index]下的链表
    private typealias Element = (key: Key, value: Value)
    private typealias Bucket = [Element]
    private var buckets: [Bucket]
    
    //哈希表中键值对的数量
    private(set) public var count = 0
    public var isEmpty: Bool { return count == 0 }
    
    //根据键值对的数量初始化哈希表
    public init(capacity: Int) {
        assert(capacity > 0)
        buckets = Array<Bucket>(repeatElement([], count: capacity))
    }
    
    //哈希表基本操作：查、改、删
    public subscript(key: Key) -> Value? {
        get {
            return value(forKey: key)
        }
        set {
            if let value = newValue {
                updateValue(value, forKey: key)
            } else {
                removeValue(forKey: key)
            }
        }
    }
    
    //查
    public func value(forKey key: Key) -> Value? {
        //根据key计算在哈希表中的位置
        let index = self.index(forKey: key)
        for element in buckets[index] {
            //每一个element以key-value的形式存储
            if element.key == key {
                return element.value
            }
        }
        //key不在哈希表
        return nil
    }
    
    //改
    @discardableResult public mutating func updateValue(_ value: Value, forKey key: Key) -> Value? {
        //根据key计算在哈希表中的位置
        let index = self.index(forKey: key)
        //查
        for (i, element) in buckets[index].enumerated() {
            if element.key == key {
                let oldValue = element.value
                buckets[index][i].value = value
                return oldValue
            }
        }
        
        //key不在哈希表-增
        buckets[index].append((key: key, value: value))
        count += 1
        return nil
    }
    
    //删
    @discardableResult public mutating func removeValue(forKey key: Key) -> Value? {
        //根据key计算在哈希表中的位置
        let index = self.index(forKey: key)
        //查
        for (i, element) in buckets[index].enumerated() {
            if element.key == key {
                buckets[index].remove(at: i)
                count -= 1
                return element.value
            }
        }
        //key不在哈希表
        return nil
    }
    
    //清空哈希表
    public mutating func removeAll() {
        buckets = Array<Bucket>(repeatElement([], count: buckets.count))
        count = 0
    }
    
    //根据key计算在哈希表中的位置index
    //哈希表的大小最好取比最大容量大的一个素数避免太多冲突
    private func index(forKey key: Key) -> Int {
        return abs(key.hashValue % buckets.count)
    }
}

extension HashTable: CustomStringConvertible {
    public var description: String {
        //把每个bucket中的元素map成key=value字符串形式，再将整个所有bucket转换为一个字符串数组
        let pairs = buckets.flatMap { b in b.map { e in "\(e.key) = \(e.value)" } }
        return pairs.joined(separator: ", ")
    }
    
    public var debugDescription: String {
        var str = ""
        for (i, bucket) in buckets.enumerated() {
            let pairs = bucket.map { e in "\(e.key) = \(e.value)" }
            str += "bucket \(i): " + pairs.joined(separator: ", ") + "\n"
        }
        return str
    }
}
