//
//  AdjacencyMatrixGraph.swift
//  DataStructures
//
//  Created by 乔一 on 2023/3/8.
//

import Foundation

//领接矩阵表示法
open class AdjacencyMatrixGraph<T>: AbstractGraph<T> where T: Hashable {
    
    //adjacencyMatrix[i][j]的值代表i节点与j节点之间的联系，nil是无联系
    fileprivate var adjacencyMatrix: [[Double?]] = []
    fileprivate var _vertices: [Vertex<T>] = []
    
    public required init() {
        super.init()
    }
    
    public required init(fromGraph graph: AbstractGraph<T>) {
        super.init(fromGraph: graph)
    }
    
    open override var vertices: [Vertex<T>] {
        return _vertices
    }
    
    open override var edges: [Edge<T>] {
        var edges = [Edge<T>]()
        for row in 0 ..< adjacencyMatrix.count {
            for column in 0 ..< adjacencyMatrix.count {
                if let weight = adjacencyMatrix[row][column] {
                    edges.append(Edge(from: vertices[row], to: vertices[column], weight: weight))
                }
            }
        }
        return edges
    }
    
    //创建节点
    //时间复杂度：O(n^2)，因为需要调整整个矩阵的大小.
    open override func createVertex(_ data: T) -> Vertex<T> {
        //vertices中是否有包含data值的vertex
        let matchingVertices = vertices.filter { vertex in
            return vertex.data == data
        }
        
        if matchingVertices.count > 0 {
            return matchingVertices.last!
        }
        
        //vertex不存在则创建新vertex
        let vertex = Vertex(data: data, index: adjacencyMatrix.count)
        
        //扩展矩阵的每一行
        for i in 0 ..< adjacencyMatrix.count {
            adjacencyMatrix[i].append(nil)
        }
        
        //在矩阵中加入一行
        let newRow = [Double?](repeating: nil, count: adjacencyMatrix.count + 1)
        adjacencyMatrix.append(newRow)
        
        _vertices.append(vertex)
        
        return vertex
    }
    
    open override func addDirectedEdge(_ from: Vertex<T>, to: Vertex<T>, withWeight weight: Double?) {
        adjacencyMatrix[from.index][to.index] = weight
    }
    
    open override func addUndirectedEdge(_ vertices: (Vertex<T>, Vertex<T>), withWeight weight: Double?) {
        addDirectedEdge(vertices.0, to: vertices.1, withWeight: weight)
        addDirectedEdge(vertices.1, to: vertices.0, withWeight: weight)
    }
    
    //查询某条边的权重
    open override func weightFrom(_ sourceVertex: Vertex<T>, to destinationVertex: Vertex<T>) -> Double? {
        return adjacencyMatrix[sourceVertex.index][destinationVertex.index]
    }
    
    //查询某个节点的边
    open override func edgesFrom(_ sourceVertex: Vertex<T>) -> [Edge<T>] {
        var outEdges = [Edge<T>]()
        let fromIndex = sourceVertex.index
        for column in 0..<adjacencyMatrix.count {
            if let weight = adjacencyMatrix[fromIndex][column] {
                outEdges.append(Edge(from: sourceVertex, to: vertices[column], weight: weight))
            }
        }
        return outEdges
    }
    
    //定义自定义类型的描述字符串，调用print函数时会打印description中的内容
    /*
     样例：
     [[nil, 1.0, nil, nil, nil]    v1
     [nil, nil, 1.0, nil, 3.2]    v2
     [nil, nil, nil, 4.5, nil]    v3
     [2.8, nil, nil, nil, nil]    v4
     [nil, nil, nil, nil, nil]]   v5

      v1   v2   v3   v4   v5
     */
    open override var description: String {
        var grid = [String]()
        let n = self.adjacencyMatrix.count
        for i in 0..<n {
            var row = ""
            for j in 0..<n {
                if let value = self.adjacencyMatrix[i][j] {
                    let number = NSString(format: "%.1f", value)
                    row += "\(value >= 0 ? " " : "")\(number) "
                } else {
                    row += "  ø  "
                }
            }
            grid.append(row)
        }
        return (grid as NSArray).componentsJoined(by: "\n")
    }
    
}
