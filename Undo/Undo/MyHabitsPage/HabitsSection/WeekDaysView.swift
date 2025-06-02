//
//  WeekDaysView.swift
//  Undo
//
//  Created by AbdelRahman Mohammad on 01/06/2025.
//

import SwiftData
import SwiftUI



// MARK: - Week Days View
struct WeekDaysView: View {
    // MARK: Properties
    let habit: Habit
    let weekStartDate: Date
    let today: Date
    let modelContext: ModelContext
    
    // MARK: Computed Properties
    private var daysInThisWeek: [Date] {
        // Reference: LL#1
        (0..<7).compactMap {
            DateUtils.calendar.date(byAdding: .day, value: $0, to: weekStartDate)
        }
    }
    
    // MARK: Body
    var body: some View {
        HStack(spacing: 4) {
            ForEach(daysInThisWeek, id: \.self) { day in
                DayCompletionView(
                    habit: habit,
                    date: day,
                    today: today,
                    action: { toggleCompletionForDay(day) } // Reference: DD#6
                )
                .frame(maxWidth: .infinity)
            }
        }
        //.padding(.horizontal, 2)
    }
    
    // MARK: Functions
    private func toggleCompletionForDay(_ date: Date) {
        let log = habit.log(for: date, modelContext: modelContext)
        log.isCompleted.toggle()
    }
}





// MARK: - Preview
#Preview {
    @Previewable @Environment(\.modelContext) var modelContext
    WeekDaysView(habit: Habit.sampleData[0], weekStartDate: Date.now, today: Date.now, modelContext: modelContext)
}
