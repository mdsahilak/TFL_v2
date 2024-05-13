//
//  TrackSectionInfo.swift
//
//
//  Created by Sahil Ak on 13/05/24.
//

import Foundation

struct TrackSectionInfo: CustomStringConvertible, Equatable {
    var start: String
    var end: String
    
    var line: String
    var direction: String
    
    var delay: Double
    
    init(start: String, end: String, line: String, direction: String, delay: Double = 0.0) {
        self.start = start
        self.end = end
        self.line = line
        self.direction = direction
        self.delay = delay
    }
    
    init(station: String, edge: Edge, delay: Double = 0.0) {
        self.start = station
        self.end = edge.destination
        
        self.line = edge.line
        self.direction = edge.direction
        
        self.delay = delay
    }
    
    var description: String {
        "\(line.capitalized.trimmingCharacters(in: .whitespacesAndNewlines)) (\(direction)) : \(start) to \(end) - \(delay) min delay"
    }
}

