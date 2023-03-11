//
//  GraphForBFS.swift
//  DataStructuresSwift
//
//  Created by 乔一 on 2023/3/8.
//

import Foundation

// MARK: - Node
public class Node: CustomStringConvertible, Equatable {
    //Node所有领接点
    public var neighbors: [Edge]
    //Node的值
    public private(set) var label: String
    public var distance: Int?
    public var visited: Bool
    
    public init(label: String) {
        self.label = label
        neighbors = []
        visited = false
    }
    
    //定义自定义类型的描述字符串，调用print函数时会打印description中的内容
    public var description: String {
        if let distance = distance {
            return "Node(label: \(label), distance: \(distance))"
        }
        return "Node(label: \(label), distance: infinity)"
    }
    
    public var hasDistance: Bool {
        return distance != nil
    }
    
    //尾随闭包 { $0 === edge } 作为 index(where:) 方法的参数。该闭包使用了一个全等于操作符 ===，它用于比较两个对象是否引用同一个实例。因此，该闭包返回值为 true 表示数组中的某个元素与传入参数 edge 是同一个对象
    public func remove(edge: Edge) {
        neighbors.remove(at: neighbors.firstIndex { $0 === edge }!)
    }
}

//使Node遵循Equatable协议
public func == (lhs: Node, rhs: Node) -> Bool {
    return lhs.label == rhs.label && lhs.neighbors == rhs.neighbors
}

// MARK: - Edge领接点
public class Edge: Equatable {
    public var neighbor: Node
    
    public init(neighbor: Node) {
        self.neighbor = neighbor
    }
}

//使Edge遵循Equatable协议
public func == (lhs: Edge, rhs: Edge) -> Bool {
    return lhs.neighbor == rhs.neighbor
}

// MARK: - Graph
public class Graph: CustomStringConvertible, Equatable {
    public private(set) var nodes: [Node]
    
    public init() {
        self.nodes = []
    }
    
    public func addNode(_ label: String) -> Node {
        let node = Node(label: label)
        nodes.append(node)
        return node
    }
    
    public func addEdge(_ source: Node, neighbor: Node) {
        let edge = Edge(neighbor: neighbor)
        source.neighbors.append(edge)
    }
    
    //定义自定义类型的描述字符串，调用print函数时会打印description中的内容
    public var description: String {
        var description = ""
        
        for node in nodes {
            if !node.neighbors.isEmpty {
                description += "[node: \(node.label) edges: \(node.neighbors.map { $0.neighbor.label})]"
            }
        }
        return description
    }
    
    public func findNodeWithLabel(label: String) -> Node {
        return nodes.filter { $0.label == label }.first!
    }
    
    public func duplicate() -> Graph {
        let duplicated = Graph()
        
        for node in nodes {
            _ = duplicated.addNode(node.label)
        }
        
        for node in nodes {
            for edge in node.neighbors {
                let source = duplicated.findNodeWithLabel(label: node.label)
                let neighbour = duplicated.findNodeWithLabel(label: edge.neighbor.label)
                duplicated.addEdge(source, neighbor: neighbour)
            }
        }
        
        return duplicated
    }
}

//使Graph遵循Equatable协议
public func == (lhs: Graph, rhs: Graph) -> Bool {
    return lhs.nodes == rhs.nodes
}
