//
//  Habit.swift
//  Undo
//
//  Created by AbdelRahman Mohammad on 20/05/2025.
//

import Foundation
import SwiftData

@Model
class Habit {
    // MARK: - Properties
    var name: String
    var iconName: String
    var creationDate: Date
    
    // Marked as optional to handle cases where: logs haven't been created yet, failed to load, or was intentionally cleared.
    @Relationship(deleteRule: .cascade) var logs: [HabitLog]?
    
    
    
    // MARK: - Initialization
    init(name: String, iconName: String, creationDate: Date) {
        self.name = name
        self.iconName = iconName
        self.creationDate = creationDate
    }
    
    
    
    // MARK: - Methods
    /*
     Checks whether there is a completed log entry for the specified date.
     Parameters:
        - date: The date to check for completed logs
        - calendar: The calendar to use for date comparison (defaults to user's current calendar, e.g., Calendar.gregorian)
     Returns: `true` if a completed log exists for the given date, `false` otherwise
     
     Important Notes:
     Manually comparing dates is error-prone due to: Time zones, Daylight saving time, Different calendar systems, Etc.
     To handle all these edge cases correctly, we use the built-in Calendar instance.
     Which ignores time components (hours, minutes, seconds), and respects calendar settings (Time zone, locale, and calendar system)
     */
    func isCompleted(for date: Date, calendar: Calendar = .current) -> Bool {
        // First check if logs array exists - if not, then no logs means not completed
        guard let logs = logs else { return false }
        
        // Iterate through all available logs
        for log in logs {
            // Check if this log's date is the same day as our target date
            let isSameDay = calendar.isDate(log.date, inSameDayAs: date)
            
            // If same day AND log is marked completed, we found what we need
            if isSameDay && log.isCompleted {
                return true
            }
        }
        
        // If we checked all logs and didn't find a matching completed one
        return false
    }
    
    /*
     Retrieves or creates a `HabitLog` for the specified date associated with this habit.
     
     Parameters:
       - date: The target date for the log entry.
       - context: The model context (Passable into functions).
       - calendar: (Optional) Calendar for date comparison. Defaults to the user's current calendar.
     
     Returns: An existing log if one exists for the specified date, otherwise a newly created log.
     
     Note: The function first checks for an existing log matching the date. If none exists,
     it creates a new log, inserts it into the database, and associates it with this habit.
     
     Association between the HabitLog and the Habit is established through:
     1 - The new log's habit property points to self.
     2 - The log is appended to self.logs.
     */
    func log(for date: Date, context: ModelContext, calendar: Calendar = .current) -> HabitLog {
        // Attempt to find an existing log for the requested date
        if let existingLog = logs?.first(where: { log in
            calendar.isDate(log.date, inSameDayAs: date)
        }) {
            return existingLog
        }
        
        // Create and configure a new log if none exists
        let newLog = HabitLog(date: date, habit: self)
        context.insert(newLog)
        self.logs?.append(newLog)
        return newLog
    }
}
