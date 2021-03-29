//
//  Floor+CoreDataClass.swift
//  RoomTracker
//
//  Created by Matthew Sousa on 3/26/21.
//
//

import Foundation
import CoreData

@objc(Floor)
public class Floor: NSManagedObject {
    
    let floorManager = FloorManager()
    
    /// Update selected property
    func update(name: String) {
        if self.name != name {
            self.name = name
        }
        if self.hasChanges == true {
            floorManager.saveSelectedContext()
        }
        
    }

}
