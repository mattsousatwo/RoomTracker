//
//  String+EXT.swift
//  RoomTracker
//
//  Created by Matthew Sousa on 3/26/21.
//

import Foundation

extension String {
        
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
    
}
