//
//  Vertex.swift
//
//
//  Created by 乔一 on 2023/3/9.
//

import Foundation

//节点
open class Vertex {
    //节点值
    open var identifier: String

    //节点领接点，包含一个节点和权重
    open var neighbors: [(Vertex, Double)] = []

    //初始化节点到起点的距离
    open var pathLengthFromStart = Double.infinity

    //初始化到此节点的路径
    open var pathVerticesFromStart: [Vertex] = []

    public init(identifier: String) {
        self.identifier = identifier
    }

    //重置此节点
    open func clearCache() {
        pathLengthFromStart = Double.infinity
        pathVerticesFromStart = []
    }
}

extension Vertex: Hashable {
    public func hash(into hasher: inout Hasher){
        hasher.combine(identifier)
    }
}

extension Vertex: Equatable {
    public static func ==(lhs: Vertex, rhs: Vertex) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}
