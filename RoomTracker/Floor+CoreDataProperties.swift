//
//  Floor+CoreDataProperties.swift
//  RoomTracker
//
//  Created by Matthew Sousa on 3/26/21.
//
//

import Foundation
import CoreData


extension Floor {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Floor> {
        return NSFetchRequest<Floor>(entityName: "Floor")
    }

    @NSManaged public var name: String?
    @NSManaged public var uuid: String?

}

extension Floor : Identifiable {

}
