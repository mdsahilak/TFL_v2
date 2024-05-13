//
//  TrainTimeInfo.swift
//
//
//  Created by Sahil Ak on 12/05/24.
//

import Foundation

struct TrainTimeInfo: Decodable {
    var line: String { line_.uppercased() }
    var direction: String { direction_.uppercased() }
    var departure: String { departure_.uppercased() }
    var destination: String { destination_.uppercased() }
    var time: Double { time_ }
    
    private var line_: String
    private var direction_: String
    private var departure_: String
    private var destination_: String
    private var time_: Double
    
    var description: String { "\(line) \(direction) \(departure) \(destination) \(time)" }
    
    enum CodingKeys: String, CodingKey {
        case line_ = "line"
        case direction_ = "direction"
        case departure_ = "departure"
        case destination_ = "destination"
        case time_ = "time"
    }
}
