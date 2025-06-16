//
//  Tips.swift
//  Undo
//
//  Created by Pixel Arabi on 13/06/2025.
//

import Foundation
import TipKit

struct AddHabitTip: Tip {
    var title: Text {
        Text("Add Your First Habit")
    }

    var message: Text? {
        Text("Tap the plus button to create a new habit.")
            .foregroundStyle(.gray)
    }
}

struct HabitContextMenuTip: Tip {
    var title: Text {
        Text("Manage Your Habit")
    }
    
    var message: Text? {
        Text("Long-press on a habit to see more options.")
            .foregroundStyle(.gray)
    }
    
    var image: Image? {
        Image(systemName: "hand.tap.fill")
    }
}
