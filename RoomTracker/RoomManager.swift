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
    
    override init() {
        super.init()
        guard let foundContext = context else { return }
        entity = NSEntityDescription.entity(forEntityName: EntityNames.room.rawValue, in: foundContext)!
        print("RoomManager()" )
    }
    
    /// Create new Room Element
    func createNew(room name: String) {
        guard let context = context else { return }
        let newRoom = Room(context: context)
        
        newRoom.uuid = genID()
        newRoom.name = name
        
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
