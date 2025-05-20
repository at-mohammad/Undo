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
    var name: String
    var iconName: String
    var creationDate: Date
    
    init(name: String, iconName: String, creationDate: Date) {
        self.name = name
        self.iconName = iconName
        self.creationDate = creationDate
    }
}
