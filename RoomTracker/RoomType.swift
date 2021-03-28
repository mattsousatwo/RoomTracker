//
//  RoomType.swift
//  RoomTracker
//
//  Created by Matthew Sousa on 3/28/21.
//

import Foundation

struct RoomType: Hashable {
    
    let name: String
    let uuid: String
    let tasks: [Task]
    
    init(name: String, tasks: [Task] = []) {
        self.name = name
        self.tasks = tasks
        let coder = CoreDataCoder()
        self.uuid = coder.genID()
    }
    
    
    
}
