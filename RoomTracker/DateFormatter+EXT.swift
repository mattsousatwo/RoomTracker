//
//  DateFormatter+EXT.swift
//  RoomTracker
//
//  Created by Matthew Sousa on 3/28/21.
//

import Foundation

extension DateFormatter {
    
    /// Convert date to string as "May 12, 1994"
    func convertToStandardDateAsString(_ date: Date) -> String {
        self.dateFormat = "MMM d, yyyy"
        let formatedDate = self.string(from: date)
        return formatedDate
    }

}
