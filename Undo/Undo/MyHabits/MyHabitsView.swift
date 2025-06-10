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
                ToolbarItemGroup(placement: .primaryAction) {
                    Button("Add Habit", systemImage: "plus") {
                        let habit = Habit()
                        path = [habit]
                    }
                }
            }
            .navigationDestination(for: Habit.self) { habit in
                EditHabitView(habit: habit, habitName: habit.name, selectedIcon: habit.iconName, creationDate: habit.creationDate)
            }
        }
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
