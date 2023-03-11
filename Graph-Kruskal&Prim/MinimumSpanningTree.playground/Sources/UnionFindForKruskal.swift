/*
 Union-Find Data Structure
 
 Performance:
 adding new set is almost O(1)
 finding set of element is almost O(1)
 union sets is almost O(1)
 */

//用于检查Kruskal算法最小生成树是否形成闭环
public struct UnionFind<T: Hashable> {
    //元素及其下标
    private var index = [T: Int]()
    //保存每个元素父节点下标
    private var parent = [Int]()
    //保存每个元素所在集合中元素数量
    private var size = [Int]()
    
    public init() {}
    
    //向并查集中添加一个新的集合
    //一开始所有的节点都为一个集合
    //index:[1:0, 2:1, 3:2, 4:3, 5:4]
    //parent:[0, 1, 2, 3, 4]
    //size:[1, 1, 1, 1, 1]
    //合并1，2，3节点
    //parent:[0, 0, 0, 3, 4]
    //size:[3, 1, 1, 1, 1]
    //合并4，5节点
    //parent:[0, 0, 0, 3, 3]
    //size:[3, 1, 1, 2, 1]
    public mutating func addSetWith(_ element: T) {
        index[element] = parent.count
        parent.append(parent.count)
        size.append(1)
    }
    
    //指定下标元素所在集合的父节点下标
    private mutating func setByIndex(_ index: Int) -> Int {
        //给定的下标本身就是父节点的索引，则返回该索引
        if parent[index] == index {
            return index
        } else {
            //否则，递归地查找其父节点
            parent[index] = setByIndex(parent[index])
            return parent[index]
        }
    }
    
    //指定元素所在集合的父节点下标
    public mutating func setOf(_ element: T) -> Int? {
        if let indexOfElement = index[element] {
            return setByIndex(indexOfElement)
        } else {
            return nil
        }
    }
    
    //将含有两个指定元素的集合合并为一个
    public mutating func unionSetsContaining(_ firstElement: T, and secondElement: T) {
        if let firstSet = setOf(firstElement), let secondSet = setOf(secondElement) {
            if firstSet != secondSet {
                //启发式合并（heuristic union），即将较小的集合树合并到较大的集合树中，从而降低整个集合树的深度
                if size[firstSet] < size[secondSet] {
                    parent[firstSet] = secondSet
                    size[secondSet] += size[firstSet]
                } else {
                    parent[secondSet] = firstSet
                    size[firstSet] += size[secondSet]
                }
            }
        }
    }
    
    public mutating func inSameSet(_ firstElement: T, and secondElement: T) -> Bool {
        if let firstSet = setOf(firstElement), let secondSet = setOf(secondElement) {
            return firstSet == secondSet
        } else {
            return false
        }
    }
}
