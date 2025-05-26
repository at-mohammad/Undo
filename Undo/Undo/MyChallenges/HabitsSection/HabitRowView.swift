//
//  HabitRowView.swift
//  Undo
//
//  Created by AbdelRahman Mohammad on 21/05/2025.
//

import SwiftUI



// MARK: - Habit Row View
struct HabitRowView: View {
    // MARK: Properties
    @Environment(\.modelContext) private var modelContext
    let habit: Habit
    let weekDaysDictionary: [Date: String]
    let today: Date
    let calendar: Calendar
    
    // MARK: Body
    var body: some View {
        VStack(alignment: .leading) {
            /// The header section (habit icon and name)
            HStack(spacing: 12) {
                Image(systemName: habit.iconName)
                    .symbolVariant(.fill)
                    .foregroundStyle(.white)
                    .frame(width: 32, height: 32)
                    .background(.black)
                    .clipShape(Circle())
                
                Text(habit.name)
                    .font(.headline)
                    .lineLimit(1)
            }
            //.padding(.bottom) // for TextField, remove if using Text!
            
            /// The week days completion section
            HStack(spacing: 12) {
                // keys.sorted() = sorting Dates by order, not letters.
                ForEach(weekDaysDictionary.keys.sorted(), id: \.self) { weekDay in
                    DayCompletionView(
                        date: weekDay,
                        dayLetter: weekDaysDictionary[weekDay] ?? "-",
                        isCompleted: habit.isCompleted(for: weekDay),
                        isToday: calendar.isDate(weekDay, inSameDayAs: today),
                        action: { toggleCompletion(for: weekDay) } // Reference: DD#5
                    )
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    // MARK: Functions
    func toggleCompletion(for date: Date) {
        let log = habit.log(for: date, modelContext: modelContext)
        log.isCompleted.toggle()
    }
}





// MARK: - Preview
#Preview {
    HabitRowView(habit: Habit.sampleData[0], weekDaysDictionary: [Date.now: "S"], today: Date.now, calendar: Calendar.current)
}
