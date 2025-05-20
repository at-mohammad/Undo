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
    @Environment(\.modelContext) var modelContext
    @Query var habits: [Habit]
    
    var body: some View {
        VStack {
            HeaderSectionView(habits: habits)
            HabitsSectionView()
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
    
    func addSampleHabits() {
        let habit1 = Habit(name: "Drink water", iconName: "drop", creationDate: .now)
        let habit2 = Habit(name: "Drink water", iconName: "drop", creationDate: .now)
        let habit3 = Habit(name: "Drink water", iconName: "drop", creationDate: .now)
        
        let habits = [habit1, habit2, habit3]
        
        habits.forEach {
            modelContext.insert($0)
        }
    }
}





// MARK: - Habits Section View
struct HabitsSectionView: View {
    var body: some View {
        Text("")
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
