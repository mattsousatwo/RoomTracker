//
//  Room+CoreDataProperties.swift
//  RoomTracker
//
//  Created by Matthew Sousa on 3/26/21.
//
//

import Foundation
import CoreData


extension Room {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Room> {
        return NSFetchRequest<Room>(entityName: "Room")
    }

    @NSManaged public var name: String?
    @NSManaged public var uuid: String?
    @NSManaged public var date: String?
    @NSManaged public var floorID: String?
    @NSManaged public var tasks: String?
    @NSManaged public var isComplete: Int16

}

extension Room : Identifiable {

}
