//
//  MyHabitsView.swift
//  Undo
//
//  Created by AbdelRahman Mohammad on 20/05/2025.
//

import SwiftData
import SwiftUI



// MARK: - My Habits View
struct MyHabitsView: View {
    // MARK: Properties
    @Environment(\.modelContext) private var modelContext
    @Query(sort: [SortDescriptor(\Habit.creationDate, order: .reverse)]) var habits: [Habit]
    @Query private var logs: [HabitLog]
    @State private var path = [Habit]()
    
    // MARK: Body
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                HeaderSectionView(habits: habits)
                HabitsSectionView(habits: habits, path: $path)
            }
            .navigationTitle("My Habits")
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    Button("Delete All Habits", systemImage: "trash") {
                        habits.forEach {
                            modelContext.delete($0)
                        }
                        logs.forEach {
                            modelContext.delete($0)
                        }
                    }
                    Button("Add Sample Habits", systemImage: "plus.app.fill") {
                        addSampleHabits()
                    }
                }
                
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button("Add Habit", systemImage: "plus") {
                        let habit = Habit()
                        path = [habit]
                    }
                    .buttonStyle(.plain)
                }
            }
            .navigationDestination(for: Habit.self) { habit in
                EditHabitView(habit: habit, habitName: habit.name, selectedIcon: habit.iconName)
            }
        }
    }
    
    // MARK: Functions
    func addSampleHabits() {
        let habits = Habit.sampleData
        
        habits.forEach { habit in
            _ = habit.log(for: .now, modelContext: modelContext)
            modelContext.insert(habit)
            habit.isInserted = true
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
        
        return MyHabitsView()
            .modelContainer(container)
    } catch {
        return Text("Failed to create container: \(error.localizedDescription)")
    }
}
