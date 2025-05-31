//
//  DateUtils.swift
//  Undo
//
//  Created by AbdelRahman Mohammad on 31/05/2025.
//

import Foundation

struct DateUtils {
    // MARK: - Static Properties
    // Reference: TT#1
    static let calendar = Calendar.current
    static let dateFormatter = {
        let formatter = DateFormatter()
        return formatter
    }() // `dateFormatter` is a stored property (not computed), initialized once by this immediately-invoked closure.
    
    // MARK: - Static Methods
    // Reference: DD#3
    static func getDayLetter(for date: Date) -> String {
        let weekdayIndex = calendar.component(.weekday, from: date) - 1 // Calendar.component(.weekday) is 1-7
        return dateFormatter.shortWeekdaySymbols[weekdayIndex].prefix(1).uppercased()
    }
    
    static func getDayNumber(for date: Date) -> Int {
        calendar.component(.day, from: date)
    }
    
    // Reference: DD#4
    static func startOfWeek(for date: Date) -> Date {
        calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: date))!
    }
    
    static func endOfWeek(for date: Date) -> Date {
        let start = startOfWeek(for: date)
        return calendar.date(byAdding: .day, value: 6, to: start)!
    }
    
    static func startOfMonth(for date: Date) -> Date {
        calendar.date(from: calendar.dateComponents([.year, .month], from: date))!
    }
    
    /// Creates an array of `Date` objects that spans full weeks covering the interval from `startDate` to `endDate`.
    // Reference: DD#5
    static func generateFullWeeksCovering(from startDate: Date, to endDate: Date) -> [Date] {
        guard startDate <= endDate else { return [] }
        
        let startOfWeek = startOfWeek(for: startDate)
        let endOfWeek = endOfWeek(for: endDate)
        
        var dates = [Date]()
        var currentDate = startOfWeek
        
        while currentDate <= endOfWeek {
            dates.append(currentDate)
            guard let nextDate = calendar.date(byAdding: .day, value: 1, to: currentDate) else {
                break // Should not happen with valid dates
            }
            currentDate = nextDate
        }
        
        return dates
    }
}
