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
    
    static let monthFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM"
        return formatter
    }()
    
    // MARK: - Static Methods
    // Reference: DD#3
    static func getDayLetter(for date: Date) -> String {
        let weekdayIndex = calendar.component(.weekday, from: date) - 1 // Calendar.component(.weekday) is 1-7
        return dateFormatter.shortWeekdaySymbols[weekdayIndex].prefix(1).uppercased()
    }
    
    static func getDayNumber(for date: Date) -> Int {
        calendar.component(.day, from: date)
    }
    static func getMonthAbbreviation(for date: Date) -> String {
        monthFormatter.string(from: date)
    }
    
    // Reference: DD#4
    static func startOfWeek(for date: Date) -> Date {
        calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: date))!
    }
    
    static func endOfWeek(for date: Date) -> Date {
        let start = startOfWeek(for: date)
        return calendar.date(byAdding: .day, value: 6, to: start)!
    }
    
    /// Generates an array of `Date` objects, each representing the start day (e.g., Sunday/Monday) of a week,
    /// spanning from the week of the `creationDate` up to and including the week of `today`.
    /// Assumes `creationDate` is not later than `today`.
    // Reference: DD#5 (Same logic)
    static func generateWeekStartDates(from creationDate: Date, to today: Date) -> [Date] {
        guard creationDate <= today else { return [] }
        
        let creationWeekStart = startOfWeek(for: creationDate)
        let currentWeekStart = startOfWeek(for: today)
        
        var weekStarts = [Date]()
        var weekStartIteration = creationWeekStart
        
        while weekStartIteration <= currentWeekStart {
            weekStarts.append(weekStartIteration)
            guard let nextWeekStart = calendar.date(byAdding: .weekOfYear, value: 1, to: weekStartIteration) else {
                break // Should not happen with valid dates
            }
            
            weekStartIteration = nextWeekStart
        }
        return weekStarts
    }
    
    /// Creates an array of `Date` objects that spans full weeks covering the interval from `startDate` to `endDate`.
    /// replaced with `generateWeekStartDates`, kept for reference.
    // Reference: DD#5
//    static func generateFullWeeksCovering(from startDate: Date, to endDate: Date) -> [Date] {
//        guard startDate <= endDate else { return [] }
//        
//        let startOfWeek = startOfWeek(for: startDate)
//        let endOfWeek = endOfWeek(for: endDate)
//        
//        var dates = [Date]()
//        var currentDate = startOfWeek
//        
//        while currentDate <= endOfWeek {
//            dates.append(currentDate)
//            guard let nextDate = calendar.date(byAdding: .day, value: 1, to: currentDate) else {
//                break // Should not happen with valid dates
//            }
//            currentDate = nextDate
//        }
//        
//        return dates
//    }
}
