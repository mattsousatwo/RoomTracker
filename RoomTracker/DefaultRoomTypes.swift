//
//  DefaultRoomTypes.swift
//  RoomTracker
//
//  Created by Matthew Sousa on 3/29/21.
//

import Foundation

enum DefaultRoomTypes {
    case classroom
    case bathroom
    case staircase
    
    var tasks: [Task] {
        switch self {
        case .bathroom:
            return [Task(title: "Sweep Floor"),
                    Task(title: "Clean Mirrors"),
                    Task(title: "Disinfect Surfaces"),
                    Task(title: "Mop Floor")]
        case .classroom:
            return [Task(title: "Sweep floor"),
                    Task(title: "Mop floor"),
                    Task(title: "Take out tash"),
                    Task(title: "Clean Windows"),
                    Task(title: "Vaccum Rug"),
                    Task(title: "Disinfect doorknobs")]
        case .staircase:
            return [Task(title: "Sweep Staircase"),
                    Task(title: "Mop Stairs")]
        }
    }
}
