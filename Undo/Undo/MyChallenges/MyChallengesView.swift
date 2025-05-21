//
//  MyChallengesView.swift
//  Undo
//
//  Created by AbdelRahman Mohammad on 20/05/2025.
//

import SwiftData
import SwiftUI



// MARK: - My Challenges View
struct MyChallengesView: View {
    // MARK: Properties
    @Environment(\.modelContext) var modelContext
    @Query var habits: [Habit]
    
    // MARK: Body
    var body: some View {
        VStack {
            if habits.isEmpty {
                emptyStateView
            } else {
                HeaderSectionView(habits: habits)
                HabitsSectionView(habits: habits)
            }
        }
        .navigationTitle("My Challenges")
        .toolbar {
            Button("Add Sample Habits", systemImage: "plus") {
                addSampleHabits()
            }
            Button("Delete All Habits", systemImage: "trash") {
                habits.forEach {
                    modelContext.delete($0)
                }
            }
        }
    }
    
    // MARK: Subviews
    private var emptyStateView: some View {
        ContentUnavailableView("No Habits", systemImage: "plus", description: Text("Tap the \(Image(systemName: "plus")) sign to add your first habit!"))
    }
    
    // MARK: Functions
    func addSampleHabits() {
        let habit1 = Habit(name: "Drink water", iconName: "drop", creationDate: .now)
        let habit2 = Habit(name: "Drink water", iconName: "drop", creationDate: .now)
        let habit3 = Habit(name: "Drink water", iconName: "drop", creationDate: .now)
        
        let habits = [habit1, habit2, habit3]
        
        habits.forEach { habit in
            _ = habit.log(for: .now, context: modelContext)
            modelContext.insert(habit)
        }
        
        habit1.log(for: .now, context: modelContext).isCompleted = true
    }
}





// MARK: - Preview
#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Habit.self, configurations: config)
        
        return MyChallengesView()
            .modelContainer(container)
    } catch {
        return Text("Failed to create container: \(error.localizedDescription)")
    }
}
