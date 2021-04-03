//
//  Task.swift
//  RoomTracker
//
//  Created by Matthew Sousa on 3/28/21.
//

import Foundation

struct Task: Hashable, Codable {
    
    /// Coding keys for encoding
    private enum CodingKeys: CodingKey {
        case title, preview, isComplete, uuid
    }
    
    /// Decoding
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        preview = try container.decode(String.self, forKey: .preview)
        isComplete = try container.decode(Bool.self, forKey: .isComplete)
        uuid = try container.decode(String.self, forKey: .uuid)
    }
    
    /// Encoding
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
        try container.encode(preview, forKey: .preview)
        try container.encode(isComplete, forKey: .isComplete)
        try container.encode(uuid, forKey: .uuid)
    }
    
    /// Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
    
    /// Equatable
    static func == (lhs: Task, rhs: Task) -> Bool {
        return lhs.uuid == rhs.uuid
    }
    
    let coredataCoder = CoreDataCoder()
    
    let title: String
    let preview: String
    var isComplete: Bool
    let uuid: String
    
    init(title: String, preview: String, isComplete: Bool? = nil, uuid: String? = nil) {
        self.title = title
        self.preview = preview
        if let isComplete = isComplete {
            self.isComplete = isComplete
        } else {
            self.isComplete = false
        }
        if let uuid = uuid {
            self.uuid = uuid
        } else {
            let coder = CoreDataCoder()
            self.uuid = coder.genID()
        }
    }
    
}
