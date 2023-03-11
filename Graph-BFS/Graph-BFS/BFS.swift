//
//  BFS.swift
//  DataStructuresSwift
//
//  Created by 乔一 on 2023/3/8.
//

import Foundation

//BFS
//思路：节点入队->出队已访问->未访问领接点入队->循环至队列为空
func breadthFirstSearch(_ graph: Graph, _ source: Node) -> [String]{
    var queue = Queue<Node>()
    queue.enqueue(source)
    
    var nodesExplored = [source.label]
    source.visited = true
    
    while let current = queue.dequeue(){
        for edge in current.neighbors{
            let neighborNode = edge.neighbor
            if !neighborNode.visited{
                queue.enqueue(neighborNode)
                neighborNode.visited = true
                nodesExplored.append(neighborNode.label)
            }
        }
    }
    
    return nodesExplored
}

//计算无权图指定节点与其他点的最短路径
func breadthFirstSearchShortestPath(graph: Graph, source: Node) -> Graph {
    //初始化图和队列
    let shortestPathGraph = graph.duplicate()
    var queue = Queue<Node>()
    
    //起点
    let sourceInShortestPathsGraph = shortestPathGraph.findNodeWithLabel(label: source.label)
    
    //入队并初始化距离
    queue.enqueue(sourceInShortestPathsGraph)
    sourceInShortestPathsGraph.distance = 0
    
    //循环开始
    while let current = queue.dequeue(){
        for edge in current.neighbors{
            let neighborNode = edge.neighbor
            //一开始所有neighborNode都没有distance，访问过后才有distance，hasdistance代表是否被访问过
            if !neighborNode.hasDistance{
                queue.enqueue(neighborNode)
                neighborNode.distance = current.distance! + 1
            }
        }
    }
    
    return shortestPathGraph
}

//计算无权图的最小生成树
func breadthFirstSearchMinimumSpanningTree(_ graph: Graph, source: Node) -> Graph {
    //初始化图和队列
    let minimumSpanningTree = graph.duplicate()
    var queue = Queue<Node>()
    
    //起点
    let sourceInMinimumSpanningTree = minimumSpanningTree.findNodeWithLabel(label: source.label)
    
    //入队并设定访问状态
    queue.enqueue(sourceInMinimumSpanningTree)
    sourceInMinimumSpanningTree.visited = true
    
    //循环开始
    while let current = queue.dequeue(){
        for edge in current.neighbors{
            let neighborNode = edge.neighbor
            if !neighborNode.visited{
                queue.enqueue(neighborNode)
                neighborNode.visited = true
            }else{
                //第二次访问时则去除边以生成树的形态
                current.remove(edge: edge)
            }
        }
    }
    
    return minimumSpanningTree
}

