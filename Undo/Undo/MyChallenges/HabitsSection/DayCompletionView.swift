//
//  DayCompletionView.swift
//  Undo
//
//  Created by AbdelRahman Mohammad on 22/05/2025.
//

import SwiftUI



// MARK: - Day Completion View
struct DayCompletionView: View {
    // MARK: Properties
    let date: Date
    let dayLetter: String
    let isCompleted: Bool
    let isToday: Bool
    let action: () -> Void
    
    // MARK: Body
    var body: some View {
        Button(action: action) {
            ZStack {
                Circle() // Outer Circle
                    .strokeBorder( // Border styling
                        isToday ? .black : .gray.opacity(0.3), // Color: black for today, light gray otherwise
                        lineWidth: 2 //isToday ? 2 : 1.5 // Thicker border for today
                    )
                    .background( // Fill color
                        Circle()
                            .fill(isCompleted ? (isToday ? .black : .gray) : .clear) // Solid if completed, transparent otherwise
                    )
                    .frame(width: 42, height: 42) // Fixed size (original: 32)
                
                Group { // Inner content
                    if isCompleted {
                        Image(systemName: "checkmark") // white checkmark icon (visible against the solid fill).
                            .font(.system(size: 14, weight: .bold))
                    } else {
                        Text(dayLetter) // Day initial
                            .font(.system(size: 14, weight: .medium))
                    }
                }
                .foregroundStyle(isCompleted ? .white : (isToday ? .black : .gray)) // Text/icon color
            }
        }
        .buttonStyle(.plain) // Disable tapping all List row buttons at once
    }
}





// MARK: - Preview
#Preview {
    DayCompletionView(date: .now, dayLetter: "S" ,isCompleted: false, isToday: false, action: {})
}
