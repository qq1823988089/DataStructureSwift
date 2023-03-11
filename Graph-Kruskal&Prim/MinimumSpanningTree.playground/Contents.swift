//有权图的最小生成树Kruskal
//思路：每次选择能够避免回路权重最小边，用unionfold来维护集合
//O(ElogE), E是边数量
func minimumSpanningTreeKruskal<T>(graph: Graph<T>) -> (cost: Int, tree: Graph<T>) {
    //权重和
    var cost: Int = 0
    var tree = Graph<T>()
    let sortedEdgeListByWeight = graph.edgeList.sorted(by: { $0.weight < $1.weight })
    
    var unionFind = UnionFind<T>()
    //一开始所有的节点都为一个集合
    for vertex in graph.vertices {
        unionFind.addSetWith(vertex)
    }
    
    for edge in sortedEdgeListByWeight {
        let v1 = edge.vertex1
        let v2 = edge.vertex2
        if !unionFind.inSameSet(v1, and: v2) {
            cost += edge.weight
            tree.addEdge(edge)
            unionFind.unionSetsContaining(v1, and: v2)
        }
    }
    
    return (cost: cost, tree: tree)
}

//有权图的最小生成树Prim
//思路：每次选择权重最小节点，用堆来维护集合
//将起始节点加入优先队列，并且不断地取出队列头部的元素进行处理。如果该节点已经访问过，则直接跳过；否则将其加入visited集合中，然后计算当前节点和其父节点之间的边的权重并累加到cost中。如果该节点有父节点，则在tree中添加一条从父节点到该节点的边，并将边的权重设为当前节点和其父节点之间的边的权重。然后遍历当前节点的所有邻居节点，将未访问过的邻居节点加入优先队列中。
//O(ElogE), E是节点数量
func minimumSpanningTreePrim<T>(graph: Graph<T>) -> (cost: Int, tree: Graph<T>) {
    var cost: Int = 0
    var tree = Graph<T>()
    
    guard let start = graph.vertices.first else {
        return (cost: cost, tree: tree)
    }
    
    var visited = Set<T>()
    var priorityQueue = PriorityQueue<(vertex: T, weight: Int, parent: T?)>(
        sort: { $0.weight < $1.weight })
    
    priorityQueue.enqueue((vertex: start, weight: 0, parent: nil))
    while let head = priorityQueue.dequeue() {
        let vertex = head.vertex
        if visited.contains(vertex) {
            continue
        }
        visited.insert(vertex)
        
        cost += head.weight
        if let prev = head.parent {
            tree.addEdge(vertex1: prev, vertex2: vertex, weight: head.weight)
        }
        
        if let neighbours = graph.adjList[vertex] {
            for neighbour in neighbours {
                let nextVertex = neighbour.vertex
                if !visited.contains(nextVertex) {
                    priorityQueue.enqueue((vertex: nextVertex, weight: neighbour.weight, parent: vertex))
                }
            }
        }
    }
    
    return (cost: cost, tree: tree)
}

/*:
 ![Graph](mst.png)
 */

var graph = Graph<Int>()
graph.addEdge(vertex1: 1, vertex2: 2, weight: 6)
graph.addEdge(vertex1: 1, vertex2: 3, weight: 1)
graph.addEdge(vertex1: 1, vertex2: 4, weight: 5)
graph.addEdge(vertex1: 2, vertex2: 3, weight: 5)
graph.addEdge(vertex1: 2, vertex2: 5, weight: 3)
graph.addEdge(vertex1: 3, vertex2: 4, weight: 5)
graph.addEdge(vertex1: 3, vertex2: 5, weight: 6)
graph.addEdge(vertex1: 3, vertex2: 6, weight: 4)
graph.addEdge(vertex1: 4, vertex2: 6, weight: 2)
graph.addEdge(vertex1: 5, vertex2: 6, weight: 6)

print("===== Kruskal's =====")
let result1 = minimumSpanningTreeKruskal(graph: graph)
print("Minimum spanning tree total weight: \(result1.cost)")
print("Minimum spanning tree:")
print(result1.tree)

print("===== Prim's =====")
let result2 = minimumSpanningTreePrim(graph: graph)
print("Minimum spanning tree total weight: \(result2.cost)")
print("Minimum spanning tree:")
print(result2.tree)
