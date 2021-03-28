//
//  FloorManager.swift
//  RoomTracker
//
//  Created by Matthew Sousa on 3/28/21.
//

import Foundation
import CoreData

class FloorManager: CoreDataPersistantManager {
    
    override init() {
        super.init()
        guard let foundContext = context else { return }
        entity = NSEntityDescription.entity(forEntityName: EntityNames.floor.rawValue, in: foundContext)!
        print("FloorManager()" )
    }
    
}
