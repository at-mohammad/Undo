//
//  Habit.swift
//  Undo
//
//  Created by Pixel Arabi on 20/05/2025.
//

import Foundation
import SwiftData

@Model
class Habit {
    // MARK: - Static Properties
    /// Sample data for previews and testing
    static let sampleData = [
        Habit(name: "Drink water", iconName: "drop", creationDate: .now.addingTimeInterval(86400 * -10)),
        Habit(name: "Buy gift", iconName: "gift", creationDate: .now.addingTimeInterval(86400 * -5)),
        Habit(name: "Read books", iconName: "book")
    ]
    
    // MARK: - Properties
    var name: String
    var iconName: String
    var creationDate: Date
    var isInserted: Bool
    
    // Marked as optional to handle cases where: logs haven't been created yet, failed to load, or was intentionally cleared.
    @Relationship(deleteRule: .cascade) var logs: [HabitLog]?
    @Relationship(deleteRule: .cascade) var reminder: Reminder?
    
    
    
    // MARK: - Initialization
    init(name: String = "", iconName: String = "star", creationDate: Date = .now, isinserted: Bool = false) {
        self.name = name
        self.iconName = iconName
        self.creationDate = creationDate
        self.isInserted = isinserted
    }
    
    
    
    // MARK: - Methods
    // Reference: DD#1
    func isCompleted(for date: Date, calendar: Calendar = .current) -> Bool {
        guard let logs = logs else { return false }

        for log in logs {
            let isSameDay = calendar.isDate(log.date, inSameDayAs: date)
            if isSameDay && log.isCompleted {
                return true
            }
        }

        return false
    }
    
    // Reference: DD#2
    func log(for date: Date, modelContext: ModelContext, calendar: Calendar = .current) -> HabitLog {
        if let existingLog = logs?.first(where: { log in
            calendar.isDate(log.date, inSameDayAs: date)
        }) {
            return existingLog
        }
        
        let newLog = HabitLog(date: date, habit: self)
        modelContext.insert(newLog)
        self.logs?.append(newLog)
        return newLog
    }
    
    func updateReminder(isEnabled: Bool, time: Date, modelContext: ModelContext) {
        if isEnabled {
            if let reminder = self.reminder {
                // If a reminder already exists, just update it.
                reminder.time = time
                reminder.isEnabled = true
                NotificationManager.instance.scheduleNotification(for: reminder)
            } else {
                // If no reminder exists, create a new one.
                let newReminder = Reminder(isEnabled: true, time: time)
                self.reminder = newReminder
                NotificationManager.instance.scheduleNotification(for: newReminder)
            }
        } else {
            // If the toggle is turned off, delete the existing reminder.
            if let reminder = self.reminder {
                NotificationManager.instance.unscheduleNotification(for: reminder)
                modelContext.delete(reminder)
                self.reminder = nil
            }
        }
    }
}
