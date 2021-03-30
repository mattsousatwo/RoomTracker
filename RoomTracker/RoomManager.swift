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
    @Published var roomsForFloor = [Room]()
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
    func createNew(room name: String, floorID: String, type: DefaultRoomTypes? = nil, tasks: [Task]? = nil) {
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
        
        let date = Date()
        let formatter = DateFormatter()
        let formattedDate = formatter.convertToStandardDateAsString(date)
        newRoom.date = formattedDate
        
        allRooms.append(newRoom)
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
    func fetchCurrentRoomsFor(floor: String) {
        
    }
    
    
    
}


/// Used to set Room.isComplete value to 0 or 1 only
enum CompleteRoomKey: Int16 {
    case complete = 1
    case incomplete = 0
}
