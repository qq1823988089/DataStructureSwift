//
//  Edge.swift
//  DataStructures
//
//  Created by 乔一 on 2023/3/8.
//

import Foundation

//边
public struct Edge<T>: Equatable where T: Hashable {
    public let from: Vertex<T>
    public let to: Vertex<T>
    public let weight: Double?
}

//定义自定义类型的描述字符串，调用print函数时会打印description中的内容
extension Edge: CustomStringConvertible {
    public var description: String {
        guard let unwrappedWeight = weight else {
            return "\(from.description) -> \(to.description)"
        }
        return "\(from.description) -(\(unwrappedWeight))-> \(to.description)"
    }
}

//使Edge遵循Hashable协议
extension Edge: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(from)
        hasher.combine(to)
        if weight != nil { hasher.combine(weight) }
    }
}

//使Edge遵循Equatable协议
public func == <T>(lhs: Edge<T>, rhs: Edge<T>) -> Bool {
    guard lhs.from == rhs.from else { return false }
    guard lhs.to == rhs.to else { return false }
    guard lhs.weight == rhs.weight else { return false}
    
    return true
}
