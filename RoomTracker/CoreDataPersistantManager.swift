//
//  CoreDataPersistantManager.swift
//  RoomTracker
//
//  Created by Matthew Sousa on 3/28/21.
//

import Foundation
import CoreData
import UIKit

class CoreDataPersistantManager: CoreDataCoder {
    var context: NSManagedObjectContext?
    var entity: NSEntityDescription?
    
    override init() {
        let appDel = UIApplication.shared.delegate as! AppDelegate
        context = appDel.persistentContainer.viewContext
    }
    
    /// Save Context
    func saveSelectedContext() {
        guard let context = context else { return }
        do {
            try context.save()
        } catch {
            print(error)
        }
        print("SaveSelectedContext")
    }
    
    /// Delete all elements for type
    func deleteAll(_ name: EntityNames) {
        guard let context = context else { return }
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: name.rawValue)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        do {
            try context.execute(deleteRequest)
        } catch {
            print(error)
        }
    }
    
    /// Delete all entities
    func deleteAllEntites() {
        for name in EntityNames.allCases {
            deleteAll(name)
        }
    }
    
    /// Delete specific element for type
    func deleteSpecificElement(_ name: EntityNames, id: String) {
        guard let context = context else { return }
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: name.rawValue)
        request.predicate = NSPredicate(format: "uuid == %@", id)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        do {
            try context.execute(deleteRequest)
        } catch {
            print(error)
        }

    }
    
    
    
}


