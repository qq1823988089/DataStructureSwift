//
//  Graph_BFSTests.swift
//  Graph-BFSTests
//
//  Created by 乔一 on 2023/3/8.
//

import XCTest
@testable import Graph_BFS

class BreadthFirstSearchTests: XCTestCase{
    //以一颗树来测试
    func testExploringTree() {
        let tree = Graph()
        
        let nodeA = tree.addNode("a")
        let nodeB = tree.addNode("b")
        let nodeC = tree.addNode("c")
        let nodeD = tree.addNode("d")
        let nodeE = tree.addNode("e")
        let nodeF = tree.addNode("f")
        let nodeG = tree.addNode("g")
        let nodeH = tree.addNode("h")
        
        tree.addEdge(nodeA, neighbor: nodeB)
        tree.addEdge(nodeA, neighbor: nodeC)
        tree.addEdge(nodeB, neighbor: nodeD)
        tree.addEdge(nodeB, neighbor: nodeE)
        tree.addEdge(nodeC, neighbor: nodeF)
        tree.addEdge(nodeC, neighbor: nodeG)
        tree.addEdge(nodeE, neighbor: nodeH)
        
        let nodesExplored = breadthFirstSearch(tree, nodeA)
        
        XCTAssertEqual(nodesExplored, ["a", "b", "c", "d", "e", "f", "g", "h"])
    }
    
    //以一张图来测试
    func testExploringGraph() {
        let graph = Graph()
        
        let nodeA = graph.addNode("a")
        let nodeB = graph.addNode("b")
        let nodeC = graph.addNode("c")
        let nodeD = graph.addNode("d")
        let nodeE = graph.addNode("e")
        let nodeF = graph.addNode("f")
        let nodeG = graph.addNode("g")
        let nodeH = graph.addNode("h")
        let nodeI = graph.addNode("i")
        
        graph.addEdge(nodeA, neighbor: nodeB)
        graph.addEdge(nodeA, neighbor: nodeH)
        graph.addEdge(nodeB, neighbor: nodeA)
        graph.addEdge(nodeB, neighbor: nodeC)
        graph.addEdge(nodeB, neighbor: nodeH)
        graph.addEdge(nodeC, neighbor: nodeB)
        graph.addEdge(nodeC, neighbor: nodeD)
        graph.addEdge(nodeC, neighbor: nodeF)
        graph.addEdge(nodeC, neighbor: nodeI)
        graph.addEdge(nodeD, neighbor: nodeC)
        graph.addEdge(nodeD, neighbor: nodeE)
        graph.addEdge(nodeD, neighbor: nodeF)
        graph.addEdge(nodeE, neighbor: nodeD)
        graph.addEdge(nodeE, neighbor: nodeF)
        graph.addEdge(nodeF, neighbor: nodeC)
        graph.addEdge(nodeF, neighbor: nodeD)
        graph.addEdge(nodeF, neighbor: nodeE)
        graph.addEdge(nodeF, neighbor: nodeG)
        graph.addEdge(nodeG, neighbor: nodeF)
        graph.addEdge(nodeG, neighbor: nodeH)
        graph.addEdge(nodeG, neighbor: nodeI)
        graph.addEdge(nodeH, neighbor: nodeA)
        graph.addEdge(nodeH, neighbor: nodeB)
        graph.addEdge(nodeH, neighbor: nodeG)
        graph.addEdge(nodeH, neighbor: nodeI)
        graph.addEdge(nodeI, neighbor: nodeC)
        graph.addEdge(nodeI, neighbor: nodeG)
        graph.addEdge(nodeI, neighbor: nodeH)
        
        let nodesExplored = breadthFirstSearch(graph, nodeA)
        
        XCTAssertEqual(nodesExplored, ["a", "b", "h", "c", "g", "i", "d", "f", "e"])
    }
    
    //以只有一个节点的图来测试
    func testExploringGraphWithASingleNode() {
        let graph = Graph()
        let node = graph.addNode("a")
        
        let nodesExplored = breadthFirstSearch(graph, node)
        
        XCTAssertEqual(nodesExplored, ["a"])
    }
    
    //测试无权图最短路径
    func testShortestPathWhenGivenTree() {
        let tree = Graph()
        let nodeA = tree.addNode("a")
        let nodeB = tree.addNode("b")
        let nodeC = tree.addNode("c")
        let nodeD = tree.addNode("d")
        let nodeE = tree.addNode("e")
        let nodeF = tree.addNode("f")
        let nodeG = tree.addNode("g")
        let nodeH = tree.addNode("h")
        tree.addEdge(nodeA, neighbor: nodeB)
        tree.addEdge(nodeA, neighbor: nodeC)
        tree.addEdge(nodeB, neighbor: nodeD)
        tree.addEdge(nodeB, neighbor: nodeE)
        tree.addEdge(nodeC, neighbor: nodeF)
        tree.addEdge(nodeC, neighbor: nodeG)
        tree.addEdge(nodeE, neighbor: nodeH)
        
        let shortestPaths = breadthFirstSearchShortestPath(graph: tree, source: nodeA)
        
        XCTAssertEqual(shortestPaths.findNodeWithLabel(label: nodeA.label).distance, 0)
        XCTAssertEqual(shortestPaths.findNodeWithLabel(label: nodeB.label).distance, 1)
        XCTAssertEqual(shortestPaths.findNodeWithLabel(label: nodeC.label).distance, 1)
        XCTAssertEqual(shortestPaths.findNodeWithLabel(label: nodeD.label).distance, 2)
        XCTAssertEqual(shortestPaths.findNodeWithLabel(label: nodeE.label).distance, 2)
        XCTAssertEqual(shortestPaths.findNodeWithLabel(label: nodeF.label).distance, 2)
        XCTAssertEqual(shortestPaths.findNodeWithLabel(label: nodeG.label).distance, 2)
        XCTAssertEqual(shortestPaths.findNodeWithLabel(label: nodeH.label).distance, 3)
    }
    
    func testShortestPathWhenGivenGraph() {
        let graph = Graph()
        
        let nodeA = graph.addNode("a")
        let nodeB = graph.addNode("b")
        let nodeC = graph.addNode("c")
        let nodeD = graph.addNode("d")
        let nodeE = graph.addNode("e")
        let nodeF = graph.addNode("f")
        let nodeG = graph.addNode("g")
        let nodeH = graph.addNode("h")
        let nodeI = graph.addNode("i")
        
        graph.addEdge(nodeA, neighbor: nodeB)
        graph.addEdge(nodeA, neighbor: nodeH)
        graph.addEdge(nodeB, neighbor: nodeA)
        graph.addEdge(nodeB, neighbor: nodeC)
        graph.addEdge(nodeB, neighbor: nodeH)
        graph.addEdge(nodeC, neighbor: nodeB)
        graph.addEdge(nodeC, neighbor: nodeD)
        graph.addEdge(nodeC, neighbor: nodeF)
        graph.addEdge(nodeC, neighbor: nodeI)
        graph.addEdge(nodeD, neighbor: nodeC)
        graph.addEdge(nodeD, neighbor: nodeE)
        graph.addEdge(nodeD, neighbor: nodeF)
        graph.addEdge(nodeE, neighbor: nodeD)
        graph.addEdge(nodeE, neighbor: nodeF)
        graph.addEdge(nodeF, neighbor: nodeC)
        graph.addEdge(nodeF, neighbor: nodeD)
        graph.addEdge(nodeF, neighbor: nodeE)
        graph.addEdge(nodeF, neighbor: nodeG)
        graph.addEdge(nodeG, neighbor: nodeF)
        graph.addEdge(nodeG, neighbor: nodeH)
        graph.addEdge(nodeG, neighbor: nodeI)
        graph.addEdge(nodeH, neighbor: nodeA)
        graph.addEdge(nodeH, neighbor: nodeB)
        graph.addEdge(nodeH, neighbor: nodeG)
        graph.addEdge(nodeH, neighbor: nodeI)
        graph.addEdge(nodeI, neighbor: nodeC)
        graph.addEdge(nodeI, neighbor: nodeG)
        graph.addEdge(nodeI, neighbor: nodeH)
        
        let shortestPaths = breadthFirstSearchShortestPath(graph: graph, source: nodeA)
        
        XCTAssertEqual(shortestPaths.findNodeWithLabel(label: nodeA.label).distance, 0)
        XCTAssertEqual(shortestPaths.findNodeWithLabel(label: nodeB.label).distance, 1)
        XCTAssertEqual(shortestPaths.findNodeWithLabel(label: nodeC.label).distance, 2)
        XCTAssertEqual(shortestPaths.findNodeWithLabel(label: nodeD.label).distance, 3)
        XCTAssertEqual(shortestPaths.findNodeWithLabel(label: nodeE.label).distance, 4)
        XCTAssertEqual(shortestPaths.findNodeWithLabel(label: nodeF.label).distance, 3)
        XCTAssertEqual(shortestPaths.findNodeWithLabel(label: nodeG.label).distance, 2)
        XCTAssertEqual(shortestPaths.findNodeWithLabel(label: nodeH.label).distance, 1)
        XCTAssertEqual(shortestPaths.findNodeWithLabel(label: nodeI.label).distance, 2)
    }
    
    //测试最小生成树
    func testMinimumSpanningTreeReturnsSameTreeWhenGivenTree() {
      let tree = Graph()
      let nodeA = tree.addNode("a")
      let nodeB = tree.addNode("b")
      let nodeC = tree.addNode("c")
      let nodeD = tree.addNode("d")
      let nodeE = tree.addNode("e")
      let nodeF = tree.addNode("f")
      let nodeG = tree.addNode("g")
      let nodeH = tree.addNode("h")
      tree.addEdge(nodeA, neighbor: nodeB)
      tree.addEdge(nodeA, neighbor: nodeC)
      tree.addEdge(nodeB, neighbor: nodeD)
      tree.addEdge(nodeB, neighbor: nodeE)
      tree.addEdge(nodeC, neighbor: nodeF)
      tree.addEdge(nodeC, neighbor: nodeG)
      tree.addEdge(nodeE, neighbor: nodeH)

      let minimumSpanningTree = breadthFirstSearchMinimumSpanningTree(tree, source: nodeA)

      XCTAssertEqual(minimumSpanningTree, tree)
    }

    func testMinimumSpanningTreeReturnsMinimumSpanningTreeWhenGivenGraph() {
      let graphAndSourceNode = createGraph()
      let expectedMinimumSpanningTree = createMinimumSpanningTree()

      let actualMinimumSpanningTree = breadthFirstSearchMinimumSpanningTree(graphAndSourceNode.graph,
                                                                    source: graphAndSourceNode.source)

      XCTAssertEqual(actualMinimumSpanningTree, expectedMinimumSpanningTree)
    }

    func createGraph() -> (graph: Graph, source: Node) {
      let graph = Graph()

      let nodeA = graph.addNode("a")
      let nodeB = graph.addNode("b")
      let nodeC = graph.addNode("c")
      let nodeD = graph.addNode("d")
      let nodeE = graph.addNode("e")
      let nodeF = graph.addNode("f")
      let nodeG = graph.addNode("g")
      let nodeH = graph.addNode("h")
      let nodeI = graph.addNode("i")

      graph.addEdge(nodeA, neighbor: nodeB)
      graph.addEdge(nodeA, neighbor: nodeH)
      graph.addEdge(nodeB, neighbor: nodeA)
      graph.addEdge(nodeB, neighbor: nodeC)
      graph.addEdge(nodeB, neighbor: nodeH)
      graph.addEdge(nodeC, neighbor: nodeB)
      graph.addEdge(nodeC, neighbor: nodeD)
      graph.addEdge(nodeC, neighbor: nodeF)
      graph.addEdge(nodeC, neighbor: nodeI)
      graph.addEdge(nodeD, neighbor: nodeC)
      graph.addEdge(nodeD, neighbor: nodeE)
      graph.addEdge(nodeD, neighbor: nodeF)
      graph.addEdge(nodeE, neighbor: nodeD)
      graph.addEdge(nodeE, neighbor: nodeF)
      graph.addEdge(nodeF, neighbor: nodeC)
      graph.addEdge(nodeF, neighbor: nodeD)
      graph.addEdge(nodeF, neighbor: nodeE)
      graph.addEdge(nodeF, neighbor: nodeG)
      graph.addEdge(nodeG, neighbor: nodeF)
      graph.addEdge(nodeG, neighbor: nodeH)
      graph.addEdge(nodeG, neighbor: nodeI)
      graph.addEdge(nodeH, neighbor: nodeA)
      graph.addEdge(nodeH, neighbor: nodeB)
      graph.addEdge(nodeH, neighbor: nodeG)
      graph.addEdge(nodeH, neighbor: nodeI)
      graph.addEdge(nodeI, neighbor: nodeC)
      graph.addEdge(nodeI, neighbor: nodeG)
      graph.addEdge(nodeI, neighbor: nodeH)

      return (graph, nodeA)
    }

    func createMinimumSpanningTree() -> Graph {
      let minimumSpanningTree = Graph()

      let nodeA = minimumSpanningTree.addNode("a")
      let nodeB = minimumSpanningTree.addNode("b")
      let nodeC = minimumSpanningTree.addNode("c")
      let nodeD = minimumSpanningTree.addNode("d")
      let nodeE = minimumSpanningTree.addNode("e")
      let nodeF = minimumSpanningTree.addNode("f")
      let nodeG = minimumSpanningTree.addNode("g")
      let nodeH = minimumSpanningTree.addNode("h")
      let nodeI = minimumSpanningTree.addNode("i")

      minimumSpanningTree.addEdge(nodeA, neighbor: nodeB)
      minimumSpanningTree.addEdge(nodeA, neighbor: nodeH)
      minimumSpanningTree.addEdge(nodeB, neighbor: nodeC)
      minimumSpanningTree.addEdge(nodeH, neighbor: nodeG)
      minimumSpanningTree.addEdge(nodeH, neighbor: nodeI)
      minimumSpanningTree.addEdge(nodeC, neighbor: nodeD)
      minimumSpanningTree.addEdge(nodeC, neighbor: nodeF)
      minimumSpanningTree.addEdge(nodeD, neighbor: nodeE)

      return minimumSpanningTree
    }
}
