//
//  Vertex.swift
//  DataStructures
//
//  Created by 乔一 on 2023/3/8.
//

import Foundation

//节点
public struct Vertex<T>: Equatable where T: Hashable {
    public var data: T
    public let index: Int
}

//定义自定义类型的描述字符串，调用print函数时会打印description中的内容
extension Vertex: CustomStringConvertible {
    public var description: String {
        return "\(index): \(data)"
    }
}

//使Vertex遵循Hashable协议
extension Vertex: Hashable {
    public func hasher(into hasher: inout Hasher) {
        hasher.combine(data)
        hasher.combine(index)
    }
}

//使Vertex遵循Equatable协议
public func ==<T>(lhs: Vertex<T>, rhs: Vertex<T>) -> Bool {
    guard lhs.index == rhs.index else {
        return false
    }
    
    guard lhs.data == rhs.data else {
        return false
    }
    
    return true
}
