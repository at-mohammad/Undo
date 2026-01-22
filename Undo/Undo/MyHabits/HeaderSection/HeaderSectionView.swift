//
//  HeaderSectionView.swift
//  Undo
//
//  Created by AbdelRahman Mohammad on 20/05/2025.
//

import SwiftUI



// MARK: - Header Section View
struct HeaderSectionView: View {
    // MARK: Properties
    let habits: [Habit]
    private let today = Date.now
    
    // MARK: Computed Properties
    private var completedTodayCount: Int {
        habits.filter { $0.isCompleted(for: today) }.count
    }
    
    private var uncompletedTodayCount: Int {
        habits.count - completedTodayCount
    }
    
    private var nextHabit: Habit? {
        // Find the first uncompleted habit for today.
        habits.first(where: { !$0.isCompleted(for: today) })
    }
    
    private var progress: Double {
        guard !habits.isEmpty else { return 0 } // avoid division by zero
        return Double(completedTodayCount) / Double(habits.count)
    }
    
    // MARK: Body
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            // Next Habit Pill
            NextHabitView(habit: nextHabit)
            
            // Date Title
            DateHeaderView(date: today)
                .padding(.horizontal)
            
            // Linear Progress Bar
            DailyProgressView(uncompletedCount: uncompletedTodayCount, totalCount: habits.count, progress: progress)
                .padding(.horizontal)
        }
        .padding(.top)
    }
}





// MARK: - Preview
#Preview {
    HeaderSectionView(habits: Habit.sampleData)
        //.preferredColorScheme(.dark)
}
