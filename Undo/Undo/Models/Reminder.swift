//
//  Reminder.swift
//  Undo
//
//  Created by AbdelRahman Mohammad on 29/06/2025.
//

import Foundation
import SwiftData

@Model
class Reminder {
    // MARK: - Properties
    var id = UUID()
    var isEnabled: Bool
    var time: Date
    var habit: Habit?

    // MARK: - Initialization
    init(isEnabled: Bool, time: Date, habit: Habit? = nil) {
        self.isEnabled = isEnabled
        self.time = time
        self.habit = habit
    }
    
    // MARK: - Methods
    // Ensuring a non-optional String is always returned before use
    func getHabitName() -> String {
        habit?.name ?? ""
    }
}
