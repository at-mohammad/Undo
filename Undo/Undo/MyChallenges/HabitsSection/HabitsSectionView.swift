//
//  HabitsSectionView.swift
//  Undo
//
//  Created by AbdelRahman Mohammad on 21/05/2025.
//

import SwiftUI



// MARK: - Habits Section View
struct HabitsSectionView: View {
    // MARK: Properties
    let habits: [Habit]
    
    // Reference: TT#1
    // MARK: Expensive Instances
    private let dateFormatter = DateFormatter()
    private let calendar = Calendar.current
    private let today = Date.now
    
    // MARK: Computed Properties
    private var weekDaysDictionary: [Date: String] {
        // Reference: DD#3
        let weekDays = (0..<7).reversed().compactMap {
            calendar.date(byAdding: .day, value: -$0, to: today)
        }
        
        // Reference: LL#3
        return Dictionary(uniqueKeysWithValues: weekDays.map { weekDay in
            // Reference: DD#4
            let dayLetter = dateFormatter.shortWeekdaySymbols[
                calendar.component(.weekday, from: weekDay) - 1
            ].prefix(1).uppercased()
            return (weekDay, dayLetter)
        })
    }
    
    // MARK: Body
    var body: some View {
        if habits.isEmpty {
            emptyStateView
        } else {
            List {
                ForEach(habits) { habit in
                    HabitRowView(habit: habit, weekDaysDictionary: weekDaysDictionary, today: today, calendar: calendar)
                        .listRowSeparator(.hidden)
                        .padding(12)
                }
            }
            .listStyle(.plain)
            //.scrollBounceBehavior(.basedOnSize)
            .scrollContentBackground(.hidden)
            .scrollDismissesKeyboard(.interactively)
        }
    }
    
    // MARK: Subviews
    private var emptyStateView: some View {
        ContentUnavailableView("No Habits", systemImage: "plus", description: Text("Tap the \(Image(systemName: "plus")) sign to add your first habit!"))
    }
}





// MARK: - Preview
#Preview {
    HabitsSectionView(habits: Habit.sampleData)
}
