//
//  HabitLog.swift
//  Undo
//
//  Created by AbdelRahman Mohammad on 21/05/2025.
//

import Foundation
import SwiftData

@Model
class HabitLog {
    // MARK: - Properties
    var date: Date
    var isCompleted: Bool
    var habit: Habit?
    
    
    
    // MARK: - Initialization
    init(date: Date = Date.now, isCompleted: Bool = false, habit: Habit? = nil) {
        self.date = date
        self.isCompleted = isCompleted
        self.habit = habit
    }
}
