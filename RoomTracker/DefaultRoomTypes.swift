//
//  DefaultRoomTypes.swift
//  RoomTracker
//
//  Created by Matthew Sousa on 3/29/21.
//

import Foundation

enum DefaultRoomTypes: Int, CaseIterable {
    case classroom = 0
    case bathroom = 1
    case staircase = 2
    
    var tasks: [Task] {
        switch self {
        case .bathroom:
            return roomType.tasks
        case .classroom:
            return roomType.tasks
        case .staircase:
            return roomType.tasks
        }
    }
    
    var roomType: RoomType {
        switch self {
        case .bathroom:
            return RoomType(name: "Bathroom", tasks: [Task(title: "Sweep Floor", preview: "Sweep"),
                                                      Task(title: "Clean Mirrors", preview: "Mirrors"),
                                                      Task(title: "Disinfect Surfaces", preview: "Disinfect"),
                                                      Task(title: "Mop Floor", preview: "Mop"),
                                                      Task(title: "Take out trash", preview: "Trash")])
        case .classroom:
            return RoomType(name: "Classroom", tasks: [Task(title: "Sweep floor", preview: "Sweep"),
                                                       Task(title: "Mop floor", preview: "Mop"),
                                                       Task(title: "Take out tash", preview: "Trash"),
                                                       Task(title: "Clean Windows", preview: "Windows"),
                                                       Task(title: "Vaccum Rug", preview: "Vaccum"),
                                                       Task(title: "Disinfect doorknobs", preview: "Disinfect")])
        case .staircase:
            return RoomType(name: "Staircase", tasks: [Task(title: "Sweep Staircase", preview: "Sweep"),
                                                       Task(title: "Mop Stairs", preview: "Mop")])
        }
    }
}
