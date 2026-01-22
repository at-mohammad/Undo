//
//  NextHabitView.swift
//  Undo
//
//  Created by AbdelRahman Mohammad on 19/01/2026.
//

import SwiftUI



// MARK: - Next Habit View
struct NextHabitView: View {
    // MARK: Properties
    let habit: Habit?
    
    // MARK: Computed Properties
    // Check if there are no more habits for today.
    private var isFinished: Bool {
        habit == nil
    }
    
    private var statusText: String {
        // modern syntax of `if let habit = habit` to get the unwrapped habit
        // this will remove the need for habit?.name
        if let habit {
            return "Next: \(habit.name)"
        } else {
            return String(localized: "All done for today!")
        }
    }
    
    private var iconName: String {
        habit?.iconName ?? "checkmark"
    }
    
    // MARK: Body
    var body: some View {
        HStack(spacing: 8) {
            // Text
            Text(statusText)
                .font(.subheadline.weight(.medium))
                .foregroundStyle(isFinished ? .secondary : .primary)
            
            // Icon
            Image(systemName: iconName)
                .font(.caption2)
                .foregroundStyle(isFinished ? .green : .cyan)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(.white)
        .clipShape(Capsule())
        .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2) // Reference: LL#6
        .frame(maxWidth: .infinity, alignment: .center) // This frame will take all available width and center its content within it
    }
}





// MARK: - Preview
#Preview {
    VStack{
        NextHabitView(habit: Habit.sampleData[0])
        NextHabitView(habit: nil)
    }
}
