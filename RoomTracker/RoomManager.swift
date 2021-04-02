//
//  RoomManager.swift
//  RoomTracker
//
//  Created by Matthew Sousa on 3/28/21.
//

import Foundation
import CoreData

class RoomManager: CoreDataPersistantManager, ObservableObject {
    
    @Published var allRooms = [Room]()
    @Published var currentRoomsForFloor = [Room]()
    @Published var previousRoomsForFloor = [Room]()
    @Published var selectedRoom : Room?
    
    
    
    override init() {
        super.init()
        guard let foundContext = context else { return }
        entity = NSEntityDescription.entity(forEntityName: EntityNames.room.rawValue, in: foundContext)!
        print("RoomManager()" )
    }
    
}

// Create
extension RoomManager {
    
    /// Create new Room Element
    func createNew(room name: String, floorID: String, type: DefaultRoomTypes? = nil, tasks: [Task]? = nil, date: Date? = nil) {
        guard let context = context else { return }
        let newRoom = Room(context: context)
        
        newRoom.name = name
        newRoom.uuid = genID()
        newRoom.floorID = floorID
        
        if let type = type {
            if let tasksString = encodeTasks(type.tasks) {
                newRoom.tasks = tasksString
            }
        } else if let tasks = tasks {
            if let tasksString = encodeTasks(tasks) {
                newRoom.tasks = tasksString
            }
        }
        newRoom.isComplete = CompleteRoomKey.incomplete.rawValue
        
        if let date = date {
            newRoom.date = date.asFormattedString()
        } else {
            let date = Date()
            let formatter = DateFormatter()
            let formattedDate = formatter.convertToStandardDateAsString(date)
            newRoom.date = formattedDate
        }
        currentRoomsForFloor.append(newRoom)
        saveSelectedContext()
    }

}


// Fetching
extension RoomManager {
    
    /// Fetch all Room Elements
    func fetchAllRooms() {
        guard let context = context else { return }
        let request: NSFetchRequest<Room> = Room.fetchRequest()
        do {
            allRooms = try context.fetch(request)
        } catch {
            print(error)
        }
        print("RoomTotal: \(allRooms.count)")
    }
    
    /// Pull from fetched rooms
    func extractAllRooms() -> [Room]? {
        fetchAllRooms()
        if allRooms.count == 0 {
            return nil
        }
        else {
            return allRooms
        }
        
    }
    
    /// Fetch Room by uuid
    func fetchSpecificRoom(id: String) {
        guard let context = context else { return }
        let request: NSFetchRequest<Room> = Room.fetchRequest()
        request.predicate = NSPredicate(format: "uuid == %@", id)
        do {
            let foundRoom = try context.fetch(request)
            if let room = foundRoom.first {
                selectedRoom = room
            }
        } catch {
            print(error)
        }
    }
    
    
    /// Fetch all rooms for floor from today
    func fetchCurrentRoomsFor(floor: Floor, date: String = Date().asFormattedString()) {
        guard let context = context else { return }
        let request: NSFetchRequest<Room> = Room.fetchRequest()
        guard let floorID = floor.uuid else { return }
        
        let floorIDPredicate = NSPredicate(format: "floorID == %@", floorID)
        let currentDatePredicate = NSPredicate(format: "date == %@", date)
        
        request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [floorIDPredicate, currentDatePredicate])
        
        do {
            currentRoomsForFloor = try context.fetch(request)
        } catch {
            print(error)
        }
    }
    
    /// Pull Rooms from Selected Floor
    func extractRooms(for floor: Floor) -> [Room]? {
        if currentRoomsForFloor.count == 0 {
            fetchCurrentRoomsFor(floor: floor)
        }
        if currentRoomsForFloor.count == 0 {
            recreateRooms(for: floor)
            if currentRoomsForFloor.count == 0 {
                return nil
            } else {
                return currentRoomsForFloor
            }
        } else {
            return currentRoomsForFloor
        }
    }
    
    
    /// Filter through rooms for last used rooms for floor
    func fetchPreviousRooms(for floor: Floor, date: String = Date().asFormattedString()) {
        guard let context = context else { return }
        let request: NSFetchRequest<Room> = Room.fetchRequest()
        guard let floorID = floor.uuid else { return }
        
        let floorIDPredicate = NSPredicate(format: "floorID == %@", floorID)
        let currentDatePredicate = NSPredicate(format: "date <= %@", date)
        
        
        request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [floorIDPredicate, currentDatePredicate])
        
        do {
            previousRoomsForFloor = try context.fetch(request)
        } catch {
            print(error)
        }
    }
    
    /// Create rooms for floor with todays date using previously saved rooms for floor
    func recreateRooms(for floor: Floor) {
        fetchPreviousRooms(for: floor)
        if previousRoomsForFloor.count != 0 {
            var roomSet: [Room] = []
            if let firstRoom = previousRoomsForFloor.first {
                if let firstDate = firstRoom.date {
                    for room in previousRoomsForFloor {
                        if room.date == firstDate {
                            roomSet.append(room)
                        }
                    }
                }
            }
            
            if roomSet.count != 0 {
                for room in roomSet {
                    var roomName = "No Name"
                    var floorUUID = genID()
                    let tasks = room.convertTasks()
                    var newTasks: [Task] {
                        var taskList: [Task] = []
                        for task in tasks {
                            taskList.append(Task(title: task.title, preview: task.preview, isComplete: false))
                        }
                        return taskList
                    }
                    
                    
                    if let name = room.name {
                        roomName = name
                    }
                    if let floorID = floor.uuid {
                        floorUUID = floorID
                    }
                    createNew(room: roomName, floorID: floorUUID, tasks: tasks, date: Date())
                }
            }
            
        }
        
        
        
        
        
    }
    
    
}


/// Used to set Room.isComplete value to 0 or 1 only
enum CompleteRoomKey: Int16 {
    case complete = 1
    case incomplete = 0
}
