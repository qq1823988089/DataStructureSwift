import Foundation

var vertices: Set<Vertex> = Set()

func createNotConnectedVertices() {
    let numberOfVerticesInGraph = 15
    for i in 0..<numberOfVerticesInGraph {
        let vertex = Vertex(identifier: "\(i)")
        vertices.insert(vertex)
    }
}

//设置节点之间的权重
func setupConnections() {
    for vertex in vertices {
        //每个节点所含的随机边数1-4
        let randomEdgesCount = arc4random_uniform(4) + 1
        
        for _ in 0..<randomEdgesCount {
            //每条边的随机权重0-9
            let randomWeight = Double(arc4random_uniform(10))
            //节点的领接点
            let neighborVertex = randomVertex(except: vertex)
            //确保遇到相同的领接点只设置一次权重
            if vertex.neighbors.contains(where: { $0.0 == neighborVertex }) {
                continue
            }

            //设置无向边权重
            let neighbor1 = (neighborVertex, randomWeight)
            let neighbor2 = (vertex, randomWeight)
            vertex.neighbors.append(neighbor1)
            neighborVertex.neighbors.append(neighbor2)
        }
    }
}

//随机选择领接点
func randomVertex(except vertex: Vertex) -> Vertex {
    var newSet = vertices
    newSet.remove(vertex)
    let offset = Int(arc4random_uniform(UInt32(newSet.count)))
    let index = newSet.index(newSet.startIndex, offsetBy: offset)
    return newSet[index]
}

//随机选择节点
func randomVertex() -> Vertex {
    let offset = Int(arc4random_uniform(UInt32(vertices.count)))
    let index = vertices.index(vertices.startIndex, offsetBy: offset)
    return vertices[index]
}

//初始化图
createNotConnectedVertices()
setupConnections()

//开始
let dijkstra = Dijkstra(vertices: vertices)

//确定起点
let startVertex = randomVertex()

let startTime = Date()
dijkstra.findShortestPaths(from: startVertex)
let endTime = Date()

print("calculation time is = \((endTime.timeIntervalSince(startTime))) sec")

//确定终点
let destinationVertex = randomVertex(except: startVertex)

//确定路径权重和
print(destinationVertex.pathLengthFromStart)

//确定路径
var pathVerticesFromStartString: [String] = []
for vertex in destinationVertex.pathVerticesFromStart {
    pathVerticesFromStartString.append(vertex.identifier)
}
print(pathVerticesFromStartString.joined(separator: "->"))


