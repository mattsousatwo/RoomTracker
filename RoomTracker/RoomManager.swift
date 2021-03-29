//
//  RoomManager.swift
//  RoomTracker
//
//  Created by Matthew Sousa on 3/28/21.
//

import Foundation
import CoreData

class RoomManager: CoreDataPersistantManager {
    
    @Published var allRooms = [Room]()
    @Published var roomsForFloor = [Room]()
    
    
    override init() {
        super.init()
        guard let foundContext = context else { return }
        entity = NSEntityDescription.entity(forEntityName: EntityNames.room.rawValue, in: foundContext)!
        print("RoomManager()" )
    }
    
    /// Create new Room Element
    func createNew(room name: String, floorID: String) {
        guard let context = context else { return }
        let newRoom = Room(context: context)
        
        newRoom.name = name
        newRoom.uuid = genID()
        newRoom.floorID = floorID
        newRoom.tasks = ""
        newRoom.isComplete = CompleteRoomKey.incomplete.rawValue
        
        let date = Date()
        let formatter = DateFormatter()
        let formattedDate = formatter.convertToStandardDateAsString(date)
        newRoom.date = formattedDate
        
        saveSelectedContext()
    }

    /// Fetch all Room Elements
    func fetchAllRooms() {
        guard let context = context else { return }
        let request: NSFetchRequest<Room> = Room.fetchRequest()
        do {
            allRooms = try context.fetch(request)
        } catch {
            print(error)
        }

    }
    
}

/// Used to set Room.isComplete value to 0 or 1 only
enum CompleteRoomKey: Int16 {
    case complete = 1
    case incomplete = 0
}
