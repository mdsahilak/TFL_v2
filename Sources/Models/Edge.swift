//
//  Edge.swift
//  TFL_App
//
//  Created by Sahil Ak on 12/05/24.
//

import Foundation

struct Edge {
    let destination: String
    let weight: Double
    
    let line: String
    let direction: String
    
    init(_ destination: String, _ weight: Double, line: String, direction: String) {
        self.destination = destination
        self.weight = weight
        self.line = line
        self.direction = direction
    }
}
