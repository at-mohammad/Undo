//
//  Tips.swift
//  Undo
//
//  Created by AbdelRahman Mohammad on 13/06/2025.
//

import Foundation
import TipKit

struct AddHabitTip: Tip {
    var title: Text {
        Text(String(localized: "Add Habit Tip Title"))
    }

    var message: Text? {
        Text(String(localized: "Add Habit Tip Message"))
            .foregroundStyle(.gray)
    }
}

struct HabitContextMenuTip: Tip {
    var title: Text {
        Text(String(localized: "Habit Menu Tip Title"))
    }
    
    var message: Text? {
        Text(String(localized: "Habit Menu Tip Message"))
            .foregroundStyle(.gray)
    }
    
    var image: Image? {
        Image(systemName: "hand.tap.fill")
    }
}
