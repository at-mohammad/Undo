//
//  HabitsSectionView.swift
//  Undo
//
//  Created by AbdelRahman Mohammad on 21/05/2025.
//

import SwiftData
import SwiftUI



// MARK: - Habits Section View
struct HabitsSectionView: View {
    // MARK: Properties
    @Environment(\.modelContext) private var modelContext
    let habits: [Habit]
    @Binding var path: [Habit]
    
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
                    ForEach(habits) { habit in
                        HabitRowView(habit: habit, today: today)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 12)
                            .background(.white) // To make white space tappable
                            .contextMenu {
                                Button("Edit Habit", systemImage: "pencil", action: {editHabit(habit)})
                                Button("Delete Habit", systemImage: "trash", action: {deleteHabit(habit)})
                                Button("Reset Progress", systemImage: "arrow.counterclockwise", action: {resetProgress(habit)})
                            }
                    }
                }
                .scrollTargetLayout()
            }
            .scrollIndicators(.hidden)
            .scrollTargetBehavior(.viewAligned)
            .scrollBounceBehavior(.basedOnSize)
        }
    }
    
    // MARK: Subviews
    private var emptyStateView: some View {
        ContentUnavailableView("No Habits", systemImage: "plus", description: Text("Tap the \(Image(systemName: "plus")) sign to add your first habit!"))
    }
    
    // MARK: Functions
    private func editHabit(_ habit: Habit) {
        path = [habit]
    }
    
    private func deleteHabit(_ habit: Habit) {
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
}
