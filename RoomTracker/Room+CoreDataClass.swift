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
    
    
}
