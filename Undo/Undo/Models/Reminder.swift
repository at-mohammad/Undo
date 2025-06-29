//
//  Reminder.swift
//  Undo
//
//  Created by Pixel Arabi on 29/06/2025.
//

import Foundation
import SwiftData

@Model
class Reminder {
    var id = UUID()
    var isEnabled: Bool
    var time: Date
    var habit: Habit?

    init(isEnabled: Bool = true, time: Date = Date()) {
        self.isEnabled = isEnabled
        self.time = time
    }
    
    func getHabitName() -> String {
        habit?.name ?? ""
    }
}
