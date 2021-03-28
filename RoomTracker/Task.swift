//
//  Task.swift
//  RoomTracker
//
//  Created by Matthew Sousa on 3/28/21.
//

import Foundation

struct Task: Hashable {
    
    let title: String
    let isComplete: Bool
    let uuid: String
    
    init(title: String) {
        self.title = title
        self.isComplete = false
        let coder = CoreDataCoder()
        self.uuid = coder.genID()
    }
}
