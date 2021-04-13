//
//  String+EXT.swift
//  RoomTracker
//
//  Created by Matthew Sousa on 3/31/21.
//

import Foundation

extension String {
    
    /// Compare two strings as dates to tell which one is more recent
    func compare(to dateTwo: String) -> Bool? {
        let date = DateFormatter()
        
        guard let selfAsDate = date.date(from: self) else { return nil }
        guard let dateTwoAsDate = date.date(from: dateTwo) else { return nil }
        
        if selfAsDate > dateTwoAsDate {
            return false
        } else {
            return true
        }
    }
    
}
