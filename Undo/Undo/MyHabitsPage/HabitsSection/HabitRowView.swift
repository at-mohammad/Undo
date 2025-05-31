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
    let today: Date
    
    // MARK: Computed Properties
    private var displayableDays: [Date] {
        DateUtils.generateFullWeeksCovering(from: habit.creationDate, to: today)
    }
    
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
            
            /// The week days completion section
            HStack(spacing: 12) {
                // keys.sorted() = sorting Dates by order, not letters.
                ScrollView(.horizontal) {
                    LazyHStack {
                        ForEach(displayableDays, id: \.self) { day in
                            DayCompletionView(
                                habit: habit,
                                date: day,
                                today: today,
                                action: { toggleCompletion(for: day) } // Reference: DD#6
                            )
                        }
                    }
                }
                .scrollIndicators(.hidden)
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
    HabitRowView(habit: Habit.sampleData[0], today: Date.now)
}
