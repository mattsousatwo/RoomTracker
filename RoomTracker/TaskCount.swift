//
//  TaskCount.swift
//  RoomTracker
//
//  Created by Matthew Sousa on 3/30/21.
//

import Foundation


class TaskCount {
    
    var totalCount: Int
    var completeCount: Int
    
    init(complete: Int, total: Int) {
        self.completeCount = complete
        self.totalCount = total
    }
    
    
    /// If count is equal
    var isComplete: Bool {
        if totalCount == completeCount {
            return true
        } else {
            return false
        }
    }
    
    /// Return TaskCount as String
    var asString: String {
        return "\(completeCount)/\(totalCount)"
    }
    
    /// Update count of total or complete
    func updateCount(totalCount: Int? = nil, completeCount: Int? = nil) {
        if let totalCount = totalCount {
            self.totalCount = totalCount
        }
        if let completeCount = completeCount {
            self.completeCount = completeCount
        }
    }
    
    /// Increment the complete count by 1 or a set number
    func incrementCompleteCount(by addedValue: Int = 1) {
        if completeCount + addedValue >= totalCount {
            completeCount = totalCount
        } else {
            completeCount = completeCount + addedValue
        }
    }
    
    
    
}
