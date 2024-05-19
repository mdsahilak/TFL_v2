//
//  TFLNetwork.swift
//  TFL_App
//
//  Created by Sahil Ak on 11/05/24.
//

import Foundation

struct TFLNetwork {
    private init() {  }
    
    private static var tubeMap: [String: [Edge]] = [:]
    
    private static var delayedTrackSections: [TrackSectionInfo] = []
    private static var closedTrackSections: [TrackSectionInfo] = []
    
    private static var liveTubeMap: [String: [Edge]] {
        var map = self.tubeMap
        
        // Remove closed tracks
        for closedTrack in closedTrackSections {
            if let edges = map[closedTrack.start],
               let edgeIndex = edges.firstIndex(where: { $0.matches(closedTrack) }) {
                map[closedTrack.start]!.remove(at: edgeIndex)
            }
        }
        
        // Add delays
        for delayedTrack in delayedTrackSections {
            if let edges = map[delayedTrack.start],
               let edgeIndex = edges.firstIndex(where: { $0.matches(delayedTrack) }) {
                map[delayedTrack.start]![edgeIndex].weight += delayedTrack.delay
            }
        }
        
        return map
    }
    
    // Local File URL
    // private static let url = URL(fileURLWithPath: "/Users/sahil/Desktop/Westminster/DSA_CW/TFL/TFL.json")!
    
    // Hosted File URL
    private static let url = URL(string: "https://raw.githubusercontent.com/mdsahilak/TFL_Data/main/tfl_data.json")!
    
    // MARK: - External API -
    
    /// load the TFL Train times data from the JSON File
    public static func fetchInformation() {
        do {
            let data = try Data(contentsOf: url)
            
            let decoder = JSONDecoder()
            let trainTimes = try decoder.decode([TrainTimeInfo].self, from: data)
            
            // Make station information
            for trainTime in trainTimes {
                let edge = Edge(trainTime.destination, trainTime.time, line: trainTime.line, direction: trainTime.direction)
                
                if let _ = tubeMap[trainTime.departure] {
                    tubeMap[trainTime.departure]!.append(edge)
                } else {
                    tubeMap[trainTime.departure] = [edge]
                }
            }
        } catch {
            print("ERROR: Failed to fetch TFL Train Information")
            print(error)
        }
    }
    
    /// Find the fastest route between two stations on the TFL Network
    /// - Parameters:
    ///   - stationA: The name of the departure station
    ///   - stationB: The name of the destination station
    public static func findRouteBetween(stationA: String, stationB: String) {
        let graph = Graph(adjacencyList: liveTubeMap)
        
        if let path = graph.findShortestPath(from: stationA, to: stationB) {
            TFLNetwork.showTravelJourney(for: path)
        } else {
            print("Error: Could not find a path between the given stations!")
        }
    }
    
    /// Show information about a station, including the lines available and connections to nearby stations.
    /// - Parameter station: The name of the station
    public static func showInformation(for station: String) {
        if let edges = tubeMap[station.capitalized] {
            print("Name: \(station)")
            
            let lines: Set<String> = Set(edges.map { $0.line.trimmingCharacters(in: .whitespacesAndNewlines) })
            print("Lines: \n \(lines)")
            
            print("Nearby Stations: ")
            for edge in edges {
                print(" \(edge.description)")
            }
        } else {
            print("ERROR: No Information Found!")
        }
    }
    
    /// Add a delay to a specific track section
    static func addDelay(_ track: TrackSectionInfo) {
        if getEdge(from: track.start, to: track.end) != nil {
            delayedTrackSections.append(track)
        } else {
            print("ERROR: No such track section found!")
        }
        
    }
    
    /// Remove a delay from a specific track section
    static func removeDelay(_ track: TrackSectionInfo) {
        if let index = delayedTrackSections.firstIndex(of: track) {
            delayedTrackSections.remove(at: index)
        } else {
            print("ERROR: No delayed track section with the given information was found!")
        }
    }
    
    /// Close a specific track section
    static func closeSection(_ track: TrackSectionInfo) {
        if getEdge(from: track.start, to: track.end) != nil {
            closedTrackSections.append(track)
        } else {
            print("ERROR: No such track section found!")
        }
    }
    
    /// Open a specific track section
    static func openSection(_ track: TrackSectionInfo) {
        if let index = closedTrackSections.firstIndex(of: track) {
            closedTrackSections.remove(at: index)
        } else {
            print("ERROR: No closed track section with the given information was found!")
        }
    }
    
    /// Show all the delayed track sections
    static func showDelayedSections() {
        print("Delayed Track Sections: ")
        for track in delayedTrackSections {
            print(track.description)
        }
    }
    
    /// Show all the open track sections
    static func showClosedSections() {
        print("Closed Track Sections: ")
        for track in closedTrackSections {
            print(track.description)
        }
    }
    
    // MARK: - / -
    
    private static func showTravelJourney(for path: String) {
        let stations: [String] = path.components(separatedBy: "->")
        var totalTime: Double = 0.0
        
        showDividerLine()
        print("Tube Journey from \(stations.first ?? "-") to \(stations.last ?? "-")")
        showDividerLine()
        
        for i in 0..<stations.count - 1 {
            let station = stations[i]
            let nextStation = stations[i+1]
            
            let edges = tubeMap[station] ?? []
            let edge = edges.first(where: { $0.destination == nextStation })
            
            if let edge {
                let line = edge.line.trimmingCharacters(in: .whitespacesAndNewlines)
                totalTime += edge.weight
                
                print("\(i + 1). \(line.capitalized) (\(edge.direction.capitalized)): \(station) -> \(edge.destination) : \(edge.weight) mins")
            }
        }
        
        showDividerLine()
        print("Total Journey Time: \(String(format: "%.2f", totalTime)) mins")
        showDividerLine()
    }
    
    static func getEdge(from a: String, to b: String) -> Edge? {
        let station = tubeMap[a]
        
        let edge = station?.first(where: { $0.destination == b })
        
        return edge
    }
    
    static func showDividerLine() {
        print("-----------------------------------------------------------------------")
    }
}

