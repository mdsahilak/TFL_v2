//
//  Edge.swift
//  TFL_App
//
//  Created by Sahil Ak on 12/05/24.
//

import Foundation

struct Edge: CustomStringConvertible {
    let destination: String
    var weight: Double
    
    let line: String
    let direction: String
    
    var description: String { "\(destination) - \(line.capitalized.trimmingCharacters(in: .whitespacesAndNewlines)) (\(direction.capitalized)) - \(weight) mins" }
    
    init(_ destination: String, _ weight: Double, line: String, direction: String) {
        self.destination = destination
        self.weight = weight
        self.line = line
        self.direction = direction
    }
    
    func matches(_ track: TrackSectionInfo) -> Bool {
        return destination.capitalized == track.end.capitalized && line.capitalized.trimmingCharacters(in: .whitespacesAndNewlines) == track.line.capitalized && direction.capitalized == track.direction.capitalized
    }
}
