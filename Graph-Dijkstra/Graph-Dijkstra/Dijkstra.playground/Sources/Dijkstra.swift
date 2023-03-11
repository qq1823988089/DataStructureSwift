//
//  Dijkstra.swift
//  Graph-Dijkstra
//
//  Created by 乔一 on 2023/3/9.
//

import Foundation

public class Dijkstra{
    private var totalVertices: Set<Vertex>
    
    public init(vertices: Set<Vertex>){
        self.totalVertices = vertices
    }
    
    //初始化图中所有节点
    private func clearCache(){
        totalVertices.forEach { $0.clearCache() }
    }
    
    public func findShortestPaths(from startVertex: Vertex){
        clearCache()
        
        //开始循环之前初始化起点与路径
        startVertex.pathLengthFromStart = 0
        startVertex.pathVerticesFromStart.append(startVertex)
        
        //用于确定离当前节点的最近节点
        var currentVertx: Vertex? = startVertex
        
        //当前节点为空代表已经循环过所有节点，结束算法
        while let vertex = currentVertx{
            //所有未访问节点
            totalVertices.remove(vertex)
            
            //节点的所有未访问领接点
            let filteredNeighbours = vertex.neighbors.filter { totalVertices.contains($0.0) }
            
            for neighbor in filteredNeighbours{
                let neighbourVertex = neighbor.0
                let weight = neighbor.1
                
                //节点加入后到此节点领接点的新权重
                let theoreticNewWeight = vertex.pathLengthFromStart + weight
                
                //更新领接点权重与路径
                if theoreticNewWeight < neighbourVertex.pathLengthFromStart{
                    neighbourVertex.pathLengthFromStart = theoreticNewWeight
                    neighbourVertex.pathVerticesFromStart = vertex.pathVerticesFromStart
                    neighbourVertex.pathVerticesFromStart.append(neighbourVertex)
                }
            }
            
            //更新当前节点，取未访问节点中权重最小的
            currentVertx = totalVertices.min{ $0.pathLengthFromStart < $1.pathLengthFromStart }
            
            if totalVertices.isEmpty{
                currentVertx = nil
                break
            }
            
        }
    }
}
