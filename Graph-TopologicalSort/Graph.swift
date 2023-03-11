public class Graph: CustomStringConvertible {
    public typealias Node = String
    
    private(set) public var adjacencyLists: [Node : [Node]]
    
    public init() {
        adjacencyLists = [Node: [Node]]()
    }
    
    public func addNode(_ value: Node) -> Node {
        adjacencyLists[value] = []
        return value
    }
    
    public func addEdge(fromNode from: Node, toNode to: Node) -> Bool {
        adjacencyLists[from]?.append(to)
        return adjacencyLists[from] != nil ? true : false
    }
    
    public var description: String {
        return adjacencyLists.description
    }
    
    public func adjacencyList(forNode node: Node) -> [Node]? {
        for (key, adjacencyList) in adjacencyLists {
            if key == node {
                return adjacencyList
            }
        }
        return nil
    }
}

extension Graph {
    typealias InDegree = Int
    
    func calculateInDegreeOfNodes() -> [Node : InDegree] {
        var inDegrees = [Node: InDegree]()
        
        //初始化每个节点的入度为0
        for (node, _) in adjacencyLists {
            inDegrees[node] = 0
        }
        
        //adjacencyLists是每个节点的邻接列表，表示与该节点相邻的其他节点
        //在for循环中，迭代adjacencyLists中的每一个邻接列表。每个邻接列表对应一个节点。再次遍历该节点的邻接列表中的每一个元素
        //在内层循环中，获取邻接列表中的每个节点，并将其入度值加1
        //如果节点已经在inDegrees中存在，则将其入度值加1；如果该节点还没有被添加到inDegrees中，则将其入度值初始化为1
        for (_, adjacencyList) in adjacencyLists {
            for nodeInList in adjacencyList {
                inDegrees[nodeInList] = (inDegrees[nodeInList] ?? 0) + 1
            }
        }
        return inDegrees
    }
}
