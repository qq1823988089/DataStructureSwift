//
//  DepthFirstSearch.swift
//  Graph-DFS
//
//  Created by 乔一 on 2023/3/9.
//

//递归
func depthFirstSearch(_ graph: Graph, source: Node) -> [String] {
    var nodesExplored = [source.label]
    source.visited = true
    
    for edge in source.neighbors{
        if !edge.neighbor.visited{
            nodesExplored += depthFirstSearch(graph, source: edge.neighbor)
        }
    }
    
    return nodesExplored
}
