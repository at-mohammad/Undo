//
//  HabitsSectionView.swift
//  Undo
//
//  Created by AbdelRahman Mohammad on 21/05/2025.
//

import SwiftData
import SwiftUI
import TipKit



// MARK: - Habits Section View
struct HabitsSectionView: View {
    // MARK: Properties
    @Environment(\.modelContext) private var modelContext
    let habits: [Habit]
    @Binding var path: [Habit]
    private let habitContextMenuTip = HabitContextMenuTip()
    
    // Reference: TT#1
    // MARK: Expensive Instances
    private let today = Date.now
    
    // MARK: Body
    var body: some View {
        if habits.isEmpty {
            emptyStateView
        } else {
            ScrollView {
                LazyVStack(spacing: 12) {
                    TipView(habitContextMenuTip)
                    ForEach(habits) { habit in
                        HabitRowView(habit: habit, today: today)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 12)
                            .background(AppTheme.dynamicSecondary) // To make white space tappable
                            .contextMenu {
                                Button(String(localized: "Edit Habit"), systemImage: "pencil", action: {editHabit(habit)})
                                Button(String(localized: "Delete Habit"), systemImage: "trash", action: {deleteHabit(habit)})
                                Button(String(localized: "Reset Progress"), systemImage: "arrow.counterclockwise", action: {resetProgress(habit)})
                            }
                    }
                }
                .scrollTargetLayout()
            }
            .padding(.bottom, 40) // Prevents the TabView from covering the last habit.
            .scrollIndicators(.hidden)
            .scrollTargetBehavior(.viewAligned)
        }
    }
    
    // MARK: Subviews
    private var emptyStateView: some View {
        ContentUnavailableView {
            Text(String(localized: "No Habits"))
        } description: {
            HStack(spacing: 4) {
                Text(String(localized: "Empty Page Description 1"))
                Image(systemName: "plus")
                Text(String(localized: "Empty Page Description 2"))
            }
        }
    }
    
    // MARK: Functions
    private func editHabit(_ habit: Habit) {
        path = [habit]
    }
    
    private func deleteHabit(_ habit: Habit) {
        // Unschedule any pending notifications for this habit before deletion.
        if let reminder = habit.reminder {
            NotificationManager.instance.unscheduleNotification(for: reminder)
        }
        modelContext.delete(habit)
    }
    
    private func resetProgress(_ habit: Habit) {
        guard let logs = habit.logs else { return }
        logs.forEach {
            modelContext.delete($0)
        }
    }
}





// MARK: - Preview
#Preview {
    HabitsSectionView(habits: Habit.sampleData, path: .constant(Habit.sampleData))
        .task {
            try? Tips.resetDatastore()
            try? Tips.configure([
                .displayFrequency(.immediate),
                .datastoreLocation(.applicationDefault)
            ])
        }
        .preferredColorScheme(.dark)
}
