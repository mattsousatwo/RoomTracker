//
//  RoomGroup.swift
//  RoomTracker
//
//  Created by Matthew Sousa on 4/20/21.
//

import Foundation

struct RoomGroup {

    // All rooms: weekly/monthly set of rooms
    var rooms: [Room]
    
    init(rooms: [Room]) {
        self.rooms = rooms
    }
    
    // grouped tasks - [[Task1, Task1], [Task2, Task2]]
    var tasks: [[Task]] {
        var ungroupedTasks: [[Task]] = []
        for room in rooms {
            let tasksForRoom = room.convertTasks()
            var tasks: [Task] = []
            for task in tasksForRoom {
                tasks.append(task)
            }
            ungroupedTasks.append(tasks)
        }
        var groupedTasks: [[Task]] = []
        for taskArray in ungroupedTasks {
            var likeTasks: [Task] = []
            for task in taskArray {
                for taskTwo in taskArray {
                    if task.title == taskTwo.title {
                        likeTasks.append(task)
                    }
                }
            }
            groupedTasks.append(likeTasks)
        }
        
        return groupedTasks
    }
    
    // Count of tasks in a taskArray
    var taskCount: Int {
        var count = 0
        if let taskArray = tasks.first {
            count = taskArray.count
        }
        return count
    }
    
    // Array of completion rates per task array in tasks
    var competionRatePerTask: [CompletionRate] {
        var rates: [CompletionRate] = []
        for taskArray in tasks {
            let rate = CompletionRate(tasks: taskArray)
            rates.append(rate)
        }
        return rates
    }
    
    // Total CompletionRate of all tasks 
    var completionRateOfRoom: CompletionRate {
        var complete = 0
        var total = 0
        
        for rate in competionRatePerTask {
            complete += rate.completeCount
            total += rate.totalCount
        }
        return CompletionRate(complete: complete, total: total)
    }
    
    
}
