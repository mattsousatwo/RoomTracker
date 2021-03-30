//
//  Room+CoreDataClass.swift
//  RoomTracker
//
//  Created by Matthew Sousa on 3/26/21.
//
//

import Foundation
import CoreData

@objc(Room)
public class Room: NSManagedObject {

    let roomManager = RoomManager()
    
    /// Update selected property
    func update(name: String? = nil,
                floorID: String? = nil,
                date: Date? = nil,
                tasks: [Task]? = nil,
                isComplete: CompleteRoomKey? = nil) {
        
        if let name = name {
            if name != self.name {
                self.name = name
            }
        }
        if let floorID = floorID {
            if floorID != self.floorID {
                self.floorID = floorID
            }
        }
        if let date = date {
            let formatter = DateFormatter()
            let formattedDate = formatter.convertToStandardDateAsString(date)
            if formattedDate != self.date {
                self.date = formattedDate
            }
        }
        if let tasks = tasks {
            let tasksAsString = roomManager.encodeTasks(tasks)
            if tasksAsString != self.tasks {
                self.tasks = tasksAsString
            }
        }
        if let isComplete = isComplete {
            if isComplete.rawValue != self.isComplete {
                self.isComplete = isComplete.rawValue
            }
        }
        
        if self.hasChanges == true {
            roomManager.saveSelectedContext()
        }
    }
    
    /// Convert Tasks: String to Tasks: [Task]
    func convertTasks() -> [Task] {
        var taskArray = [Task]()
        let coredataCoder = CoreDataCoder()
        if let savedTasks = self.tasks {
            if let tasks = coredataCoder.decodeTasks(savedTasks) {
                taskArray = tasks
            }
        }
        return taskArray
    }
    
    /// Complete all tasks
    func setAllTasksToComplete() {
        guard let savedTasks = self.tasks else { return }
        guard let tasks = roomManager.decodeTasks(savedTasks) else { return }
        
        var newTasks: [Task] = []
        
        for task in tasks {
            newTasks.append(Task(title: task.title, preview: task.preview, isComplete: true))
        }
        
        self.update(tasks: newTasks)
    }
    
    
}
