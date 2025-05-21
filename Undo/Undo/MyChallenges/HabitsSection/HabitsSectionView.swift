//
//  HabitsSectionView.swift
//  Undo
//
//  Created by AbdelRahman Mohammad on 21/05/2025.
//

import SwiftUI



// MARK: - Habits Section View
struct HabitsSectionView: View {
    // MARK: Properties
    let habits: [Habit]
    
    // MARK: Body
    var body: some View {
        List(habits) { habit in
            Text(habit.name)
                .listRowSeparator(.hidden)
                //.padding(.vertical, 6) list default padding
        }
    }
}





// MARK: - Preview
#Preview {
    let habit1 = Habit(name: "Drink water", iconName: "drop", creationDate: .now)
    let habit2 = Habit(name: "Drink water", iconName: "drop", creationDate: .now)
    let habit3 = Habit(name: "Drink water", iconName: "drop", creationDate: .now)
    
    let habits = [habit1, habit2, habit3]
    
    return HabitsSectionView(habits: habits)
}
