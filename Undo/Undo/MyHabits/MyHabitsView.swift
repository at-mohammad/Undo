//
//  MyHabitsView.swift
//  Undo
//
//  Created by AbdelRahman Mohammad on 20/05/2025.
//

import SwiftData
import SwiftUI
import TipKit



// MARK: - My Habits View
struct MyHabitsView: View {
    // MARK: Properties
    @Environment(\.modelContext) private var modelContext
    @Query(sort: [SortDescriptor(\Habit.creationDate, order: .reverse)]) var habits: [Habit]
    @AppStorage("isFirstTimeUserExperience") private var isFirstTimeUserExperience = true
    @State private var path = [Habit]()
    private let addHabitTip = AddHabitTip()
    
    // MARK: Body
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                HeaderSectionView(habits: habits)
                HabitsSectionView(habits: habits, path: $path)
            }
            .navigationTitle(String(localized: "My Habits"))
            // This is a required alternative since the .large mode is broken for now in ios 26
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .primaryAction) {
                    Button(String(localized: "Add Habit"), systemImage: "plus") {
                        let habit = Habit()
                        path = [habit]
                        addHabitTip.invalidate(reason: .actionPerformed) // Stop showing the tip again.
                    }
                    .popoverTip(!isFirstTimeUserExperience ? addHabitTip : nil, arrowEdge: .top)
                }
            }
            .navigationDestination(for: Habit.self) { habit in
                EditHabitView(habit: habit)
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
            .task {
                try? Tips.resetDatastore() // Make all tips eligible for display again. Helpful for testing tips behavior
                try? Tips.configure([
                    .displayFrequency(.immediate),
                    .datastoreLocation(.applicationDefault)
                ])
            }
            .modelContainer(container)
            .preferredColorScheme(.dark)
    } catch {
        return Text("Failed to create container: \(error.localizedDescription)")
    }
}
