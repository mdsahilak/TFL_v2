//
//  PriorityQueue.swift
//  TFL_App
//
//  Created by Sahil Ak on 12/05/24.
//

import Foundation
import Collections

struct PriorityQueue<T> {
    struct QEntry: Comparable {
        let element: T
        let priority: Double
        
        static func == (lhs: PriorityQueue<T>.QEntry, rhs: PriorityQueue<T>.QEntry) -> Bool {
            lhs.priority == rhs.priority
        }
        
        static func < (lhs: PriorityQueue<T>.QEntry, rhs: PriorityQueue<T>.QEntry) -> Bool {
            lhs.priority < rhs.priority
        }
        
        static func > (lhs: PriorityQueue<T>.QEntry, rhs: PriorityQueue<T>.QEntry) -> Bool {
            lhs.priority > rhs.priority
        }
    }
    
    private var entries: Heap<QEntry> = []
    
    mutating func enqueue(_ element: T, priority: Double) {
        entries.insert(.init(element: element, priority: priority))
    }

    mutating func dequeue() -> (element: T, priority: Double)? {
        if let val = entries.popMin() {
            return (val.element, val.priority)
        } else {
            return nil
        }
    }

    var isEmpty: Bool {
        return entries.isEmpty
    }
}

