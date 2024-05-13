// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

@main
struct TFL_v1 {
    static func main() {
        print("Welcome to the TFL v2 Application")

        TFLDataset.loadData()

        let graph = Graph(adjacencyList: TFLDataset.tubeNetwork)
        let (_, path) = graph.findShortestPath(from: "Marble Arch", to: "Great Portland Street")
        
        TFLDataset.showTravelJourney(for: path)
        
        while true {
            print("Please choose an option:")
            print("1: Find Route between two stations:")
            print("2: Exit")
            
            guard let input = readLine(), let option = Int(input) else {
                print("Invalid Input")
                exit(0)
            }
            
            switch option {
            case 1:
                print("Please enter starting station:")
                let station1 = readLine() ?? ""
                
                print("Please enter destination station:")
                let station2 = readLine() ?? ""
                
                let (_, path) = graph.findShortestPath(from: station1, to: station2)
                TFLDataset.showTravelJourney(for: path)
            case 2:
                print("Thank you.")
                exit(0)
            default:
                print("Please choose a valid option.")
                exit(0)
            }
        }

    }
}
