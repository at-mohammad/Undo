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
    // required to be optional in order to bound with .scrollPosition(id:)
    @State private var currentFocusedWeekStartDate: Date?
    
    // MARK: Computed Properties
    private var displayableWeekStartDates: [Date] {
        DateUtils.generateWeekStartDates(from: habit.creationDate, to: today)
    }
    
    private var currentMonthAbbreviation: String {
        DateUtils.getMonthAbbreviation(for: currentFocusedWeekStartDate ?? today)
    }
    
    // MARK: Initialization
    init(habit: Habit, today: Date) {
        self.habit = habit
        self.today = today
        
        // Reference: DD#7
        let currentWeekStartDate = DateUtils.startOfWeek(for: today)
        self._currentFocusedWeekStartDate = State(initialValue: currentWeekStartDate)
    }
    
    // MARK: Body
    var body: some View {
        VStack(alignment: .leading) {
            /// The header section (habit icon and name)
            HStack(spacing: 12) {
                Image(systemName: habit.iconName)
                    .symbolVariant(.fill)
                    .foregroundStyle(AppTheme.dynamicSecondary)
                    .frame(width: 32, height: 32)
                    .background(AppTheme.dynamicPrimary)
                    .clipShape(Circle())
                
                Text(habit.name)
                    .font(.headline)
                    .lineLimit(1)
            }
            
            /// The month abbreviation
            Text(currentMonthAbbreviation)
                .font(.caption.weight(.semibold))
                .foregroundColor(.secondary)
                .padding(.leading, 15)
            
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
            .scrollPosition(id: $currentFocusedWeekStartDate) // Sets the initial WeekDaysView and tracks changes
            .frame(height: 70) // Otherwise the ScrollView will take all available space. Adjust height as needed
        }
    }
}





// MARK: - Preview
#Preview {
    HabitRowView(habit: Habit.sampleData[0], today: Date.now)
        .preferredColorScheme(.dark)
}
