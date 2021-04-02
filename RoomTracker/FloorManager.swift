//
//  FloorManager.swift
//  RoomTracker
//
//  Created by Matthew Sousa on 3/28/21.
//

import Foundation
import CoreData

class FloorManager: CoreDataPersistantManager, ObservableObject {
    
    @Published var allFloors = [Floor]()
    lazy var defaultNewFloorName = "New Floor"
    lazy var defaultNewFloorID = "DEFAULTNEWFLOORID"
    
    override init() {
        super.init()
        guard let foundContext = context else { return }
        entity = NSEntityDescription.entity(forEntityName: EntityNames.floor.rawValue, in: foundContext)!
        print("FloorManager()" )
    }
    
    /// Create new Floor
    func createNewFloor(_ name: String, id: String? = nil) -> Floor? {
        guard let context = context else { return nil }
        let newFloor = Floor(context: context)
        
        newFloor.name = name
        if let id = id {
            newFloor.uuid = id
        } else {
            newFloor.uuid = genID()
        }
        allFloors.append(newFloor)
        saveSelectedContext()
        
        return newFloor
    }
    
    /// Create a new floor with ID: DEFAULTNEWFLOORID, name: New Floor
    func createDefaultNewFloor() {
        guard let context = context else { return }
        let newFloor = Floor(context: context)
        newFloor.name = defaultNewFloorName
        newFloor.uuid = defaultNewFloorID
        allFloors.append(newFloor)
        saveSelectedContext()
    }
    
    /// Fetch All Floors
    func fetchAll() {
        guard let context = context else { return }
        let request: NSFetchRequest<Floor> = Floor.fetchRequest()
        do {
            allFloors = try context.fetch(request)
        } catch {
            print(error)
        }
    }
    
    /// Pull from fetched floors 
    func extractAllFloors() -> [Floor]? {
        if allFloors.count == 0 {
            fetchAll()
        }
        if allFloors.count == 0 {
            return nil
        }
        else {
            return allFloors
        }
        
    }
    
    
}
