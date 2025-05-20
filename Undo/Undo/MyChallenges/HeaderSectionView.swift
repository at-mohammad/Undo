//
//  HeaderSectionView.swift
//  Undo
//
//  Created by AbdelRahman Mohammad on 20/05/2025.
//

import SwiftUI



// MARK: - Header Section View
struct HeaderSectionView: View {
    let habits: [Habit]
    
    var body: some View {
        VStack(alignment: .center) {
            ProgressCardView(completedCount: 1, totalCount: 3)
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
