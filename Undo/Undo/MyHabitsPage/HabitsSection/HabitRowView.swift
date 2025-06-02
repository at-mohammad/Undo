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
    
    // Reference: DD#7
    @State private var initiallyFocusedWeekStartDate: Date
    
    // MARK: Computed Properties
    // Get the displayable week start dates directly from DateUtils
    private var displayableWeekStartDates: [Date] {
        DateUtils.generateWeekStartDates(from: habit.creationDate, to: today)
    }
    
    // MARK: Initialization
    init(habit: Habit, today: Date) {
        self.habit = habit
        self.today = today
        
        // Reference: DD#7
        let currentWeeksStartDate = DateUtils.startOfWeek(for: today)
        self._initiallyFocusedWeekStartDate = State(initialValue: currentWeeksStartDate)
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
            
            /// The week days section
            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(displayableWeekStartDates, id: \.self) { weekStartDate in
                        WeekDaysView(
                            habit: habit,
                            weekStartDate: weekStartDate,
                            today: today,
                            modelContext: modelContext
                        )
                        .containerRelativeFrame(.horizontal) // Each WeekDaysView takes the full-width of the ScrollView's
                    }
                }
                .scrollTargetLayout() // Marks each WeekDaysView as a potential stopping point
            }
            .scrollIndicators(.hidden)
            .scrollTargetBehavior(.viewAligned) // Tells the ScrollView to align with one of those full-width WeekDaysViews
            .scrollPosition(id: .constant(Optional(initiallyFocusedWeekStartDate))) // Sets the initial WeekDaysView
            .frame(height: 70) // Otherwise the ScrollView will take all available space. Adjust height as needed
        }
    }
}





// MARK: - Preview
#Preview {
    HabitRowView(habit: Habit.sampleData[0], today: Date.now)
}
