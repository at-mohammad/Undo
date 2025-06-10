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
    let habit: Habit
    let date: Date
    let today: Date
    let action: () -> Void
    
    // MARK: Computed Properties
    private var dayNumber: Int { DateUtils.getDayNumber(for: date) }
    private var dayLetter: String { DateUtils.getDayLetter(for: date) }
    private var isCompleted: Bool { habit.isCompleted(for: date) }
    private var isToday: Bool { DateUtils.calendar.isDate(date, inSameDayAs: today) }
    private var isDisabled: Bool {
        // Disable if the day is before the habit's creation date (ignoring time)
        // OR if the day is after today (ignoring time)
        DateUtils.calendar.startOfDay(for: date) < DateUtils.calendar.startOfDay(for: habit.creationDate) ||
        DateUtils.calendar.startOfDay(for: date) > DateUtils.calendar.startOfDay(for: today)
    }
    
    // MARK: Body
    var body: some View {
        VStack {
            Button(action: action) {
                ZStack {
                    Circle() // Outer Circle
                        .strokeBorder( // Border styling
                            isToday ? .black : .gray.opacity(0.3), // Color: black for today, light gray otherwise
                            lineWidth: 2 // Border thickness
                        )
                        .background( // Fill color
                            Circle()
                                .fill(isCompleted ? (isToday ? .black : .gray) : .clear) // Solid if completed, transparent otherwise
                        )
                        .frame(width: 42, height: 42) // Fixed size (original: 32)
                    
                    Text("\(dayNumber)") // Day of the month
                        .font(.system(size: 14, weight: .medium))
                        .foregroundStyle(isCompleted ? .white : (isToday ? .black : .gray)) // Text/icon color
                }
            }
            .buttonStyle(.plain) // Disable tapping all List row buttons at once
            .disabled(isDisabled)
            // If today, provide increase/decrease haptics. Otherwise, none.
            .sensoryFeedback(isToday ? (isCompleted ? .increase : .decrease) : .impact(weight: .light, intensity: 0), trigger: isCompleted)
            
            Text(dayLetter) // Day initial
                .font(.caption)
        }
    }
}





// MARK: - Preview
#Preview {
    DayCompletionView(habit: Habit.sampleData[0], date: .now, today: .now, action: {})
}
