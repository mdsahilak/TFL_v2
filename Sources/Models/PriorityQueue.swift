//
//  PriorityQueue.swift
//  TFL_App
//
//  Created by Sahil Ak on 12/05/24.
//

import Foundation

struct PriorityQueue<T> {
    private var elements: [(T, Double)] = []

    mutating func enqueue(_ element: T, priority: Double) {
        elements.append((element, priority))
        elements.sort { $0.1 < $1.1 }
    }

    mutating func dequeue() -> (element: T, priority: Double)? {
        return elements.isEmpty ? nil : elements.removeFirst()
    }

    var isEmpty: Bool {
        return elements.isEmpty
    }
}
