//
//  Graph.swift
//  DataStructures
//
//  Created by 乔一 on 2023/3/8.
//

import Foundation

//定义Graph基类
open class AbstractGraph<T>: CustomStringConvertible where T: Hashable {
    public required init() {}
    
    public required init(fromGraph graph: AbstractGraph<T>) {
        for edge in graph.edges {
            let from = createVertex(edge.from.data)
            let to = createVertex(edge.to.data)
            
            addDirectedEdge(from, to: to, withWeight: edge.weight)
        }
    }
    
    open var description: String {
        fatalError("abstract property accessed")
    }
    
    open var vertices: [Vertex<T>] {
        fatalError("abstract property accessed")
    }
    
    open var edges: [Edge<T>] {
        fatalError("abstract property accessed")
    }
    
    //创建一个新节点
    //时间复杂度：O(n^2)，因为需要重新调整整个矩阵的大小
    open func createVertex(_ data: T) -> Vertex<T> {
        fatalError("abstract function called")
    }
    
    open func addDirectedEdge(_ from: Vertex<T>, to: Vertex<T>, withWeight weight: Double?) {
        fatalError("abstract function called")
    }
    
    open func addUndirectedEdge(_ vertices: (Vertex<T>, Vertex<T>), withWeight weight: Double?) {
        fatalError("abstract function called")
    }
    
    open func weightFrom(_ sourceVertex: Vertex<T>, to destinationVertex: Vertex<T>) -> Double? {
        fatalError("abstract function called")
    }
    
    open func edgesFrom(_ sourceVertex: Vertex<T>) -> [Edge<T>] {
        fatalError("abstract function called")
    }
}



