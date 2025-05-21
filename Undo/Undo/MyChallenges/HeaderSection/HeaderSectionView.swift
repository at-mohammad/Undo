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
    let today = Date.now
    
    // MARK: Computed Properties
    private var completedTodayCount: Int {
        habits.filter { $0.isCompleted(for: today) }.count
    }
    
    // MARK: Body
    var body: some View {
        VStack(alignment: .center) {
            ProgressCardView(completedCount: completedTodayCount, totalCount: habits.count)
                .padding()
                .frame(maxWidth: 370)
                .background(.black)
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        }
    }
}





// MARK: - Preview
#Preview {
    let habit1 = Habit(name: "Drink water", iconName: "drop", creationDate: .now)
    let habit2 = Habit(name: "Drink water", iconName: "drop", creationDate: .now)
    let habit3 = Habit(name: "Drink water", iconName: "drop", creationDate: .now)
    
    let habits = [habit1, habit2, habit3]
    
    return HeaderSectionView(habits: habits)
}
