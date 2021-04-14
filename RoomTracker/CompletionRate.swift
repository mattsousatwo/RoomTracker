//
//  CompletionRate.swift
//  RoomTracker
//
//  Created by Matthew Sousa on 3/30/21.
//

import Foundation


class CompletionRate {
    
    var totalCount: Int
    var completeCount: Int
    
    /// Manually insert a completion rate
    init(complete: Int, total: Int) {
        self.completeCount = complete
        self.totalCount = total
    }
    
    /// Get Rate From an array of Tasks
    init(tasks: [Task]) {
        var completed = 0
        var total = 0
        for task in tasks {
            if task.isComplete == true {
                completed += 1
            }
        }
        total = tasks.count
        
        self.totalCount = total
        self.completeCount = completed
    }
    
    /// If count is equal
    var isComplete: Bool {
        if totalCount == completeCount {
            return true
        } else {
            return false
        }
    }
    
    /// Return CompletionRate as String
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

    // Get percentage for completionRate
    private func getPercentage(portion: Float, total: Float) -> String {
        let divided = portion / total
        var valueString = String()
        
        let numberFormat = NumberFormatter()
        numberFormat.numberStyle = .percent
        
        if let value = numberFormat.string(from: NSNumber(value: divided)) {
            valueString = value
        }
        
        print("\n\n percentage: \(valueString)\n\n")
        return valueString
    }

    // Return a percentage as String
    var asPercentageString: String {
        var percentageString = String()
        
        if self.isComplete == true {
            percentageString = "100%"
        } else {
            percentageString = getPercentage(portion: Float(completeCount), total: Float(totalCount))
        }
        
        return percentageString
    }
    
    
   
    
    
}
