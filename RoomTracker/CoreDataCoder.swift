//
//  CoreDataCoder.swift
//  RoomTracker
//
//  Created by Matthew Sousa on 3/26/21.
//

import Foundation

class CoreDataCoder {
    
    /// Generate String ID of characters and numbers
    func genID(_ digitCount: Int = 5) -> String {
        var id = String()
        let chars = ["A", "B", "C", "D", "E", "F",
        "G", "H", "I", "J", "K", "L", "M", "N", "O",
        "P", "Q", "R", "S", "T", "U", "V", "W", "X",
        "Y", "Z"]
        
        for _ in 0..<digitCount {
            
            let randomNumber = Int.random(in: 0...5000)
            
            if randomNumber >= 2500 {
                let randomIDDigit = Int.random(in: 0...9)
                id.append("\(randomIDDigit)")
            } else {
                let characterIndex = Int.random(in: 0..<chars.count)
                let character = chars[characterIndex]
                id.append(character)
            }
            
        }
        
        return id
    }
    
    lazy var decoder = JSONDecoder()
    lazy var encoder = JSONEncoder()
    
    /// Convert [Task] to String
    func encodeTasks(_ tasks: [Task]) -> String? {
        encoder.outputFormatting = .prettyPrinted
        guard let data = try? encoder.encode(tasks) else { return nil }
        return String(data: data, encoding: .utf8)
    }
    
    /// Convert String to [Task]
    func decodeTasks(_ tasks: String) -> [Task]? {
        guard let data = tasks.data(using: .utf8) else { return nil }
        guard let taskList = try? decoder.decode([Task].self, from: data) else { return nil }
        return taskList
        
    }
    
    
    /// Convert [RoomType] to String
    func encodeRoomType(_ type: RoomType) -> String? {
        encoder.outputFormatting = .prettyPrinted
        guard let data = try? encoder.encode(type) else { return nil }
        return String(data: data, encoding: .utf8)
    }
    
    /// Convert String to [RoomType]
    func decodeRoomType(_ type: String) -> RoomType? {
        guard let data = type.data(using: .utf8) else { return nil }
        guard let roomTypeList = try? decoder.decode(RoomType.self, from: data) else { return nil }
        return roomTypeList
        
    }
    
}
