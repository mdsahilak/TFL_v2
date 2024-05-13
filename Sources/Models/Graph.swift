//
//  Graph.swift
//  TFL_App
//
//  Created by Sahil Ak on 12/05/24.
//

import Foundation

struct Graph {
    var adjacencyList: [String: [Edge]]
    
    init(adjacencyList: [String: [Edge]]) {
        self.adjacencyList = adjacencyList
    }
    
    func dijkstra(startVertex: String) -> (distances: [String: Double], paths: [String: String]) {
        var distances: [String: Double] = [:]
        var paths: [String: String] = [:]
        
        for vertex in adjacencyList.keys {
            distances[vertex] = Double.greatestFiniteMagnitude
            paths[vertex] = ""
        }
        
        distances[startVertex] = 0
        
        var priorityQueue = PriorityQueue<String>()
        
        priorityQueue.enqueue(startVertex, priority: 0)
        
        while !priorityQueue.isEmpty {
            let (currentNode, currentDistance) = priorityQueue.dequeue()!
            
            if currentDistance > distances[currentNode]! {
                continue
            }

            for edge in adjacencyList[currentNode] ?? [] {
                let newDistance = currentDistance + edge.weight
                if newDistance < distances[edge.destination, default: .greatestFiniteMagnitude] {
                    distances[edge.destination] = newDistance
                    paths[edge.destination] = currentNode
                    priorityQueue.enqueue(edge.destination, priority: newDistance)
                }
            }
        }
        
        // Routes
        var routes: [String: String] = [:]
        
        for destination in paths.keys {
            var current = destination
            var fullPath = destination
            
            while let previous = paths[current], previous != "" {
                fullPath = "\(previous)->\(fullPath)"
                current = previous
            }
            
            routes[destination] = fullPath
        }
        
        return (distances, routes)
    }
    
    func findShortestPath(from vertexA: String, to vertexB: String) -> String? {
        let start = vertexA.capitalized
        let end = vertexB.capitalized
        
        let (_, paths) = self.dijkstra(startVertex: start)
        
        let path = paths[end]
        
        return path
    }
}
