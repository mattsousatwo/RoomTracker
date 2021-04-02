//
//  Date+EXT.swift
//  RoomTracker
//
//  Created by Matthew Sousa on 3/31/21.
//

import Foundation

extension Date {
    
    /// Convert date to string as "May 12, 1994"
    func asFormattedString() -> String {
        let dateFormatter = DateFormatter()
        return dateFormatter.convertToStandardDateAsString(self)
    }
    
    
    /// Create a specific date
    func createDate(month: Int, day: Int, year: Int) -> String? {
        let calendar = Calendar.current
        let dateComponents = DateComponents(calendar: calendar,
                                            year: year,
                                            month: month,
                                            day: day)
        let date = calendar.date(from: dateComponents)
        let formattedDate = date?.asFormattedString()
        
        return formattedDate
    }
    
    
    
}
