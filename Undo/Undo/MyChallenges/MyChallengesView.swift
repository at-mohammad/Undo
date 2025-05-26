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
    @Query(sort: [SortDescriptor(\Habit.creationDate, order: .reverse)]) var habits: [Habit]
    
    // MARK: Body
    var body: some View {
        VStack {
            HeaderSectionView(habits: habits)
            HabitsSectionView(habits: habits)
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
    
    // MARK: Functions
    func addSampleHabits() {
        let habits = Habit.sampleData
        
        habits.forEach { habit in
            _ = habit.log(for: .now, modelContext: modelContext)
            modelContext.insert(habit)
        }
        
        habits[0].log(for: .now, modelContext: modelContext).isCompleted = true
    }
}





// MARK: - Preview
#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Habit.self, configurations: config)
        
        Habit.sampleData.forEach { habit in
            container.mainContext.insert(habit)
        }
        
        return MyChallengesView()
            .modelContainer(container)
    } catch {
        return Text("Failed to create container: \(error.localizedDescription)")
    }
}
