//
//  EditHabitView.swift
//  Undo
//
//  Created by AbdelRahman Mohammad on 26/05/2025.
//

import SwiftData
import SwiftUI



// MARK: - Edit Habit View
struct EditHabitView: View {
    // MARK: Properties
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    let habit: Habit
    @State var habitName: String
    @State var selectedIcon: String
    
    private let iconColumns = [GridItem(.adaptive(minimum: 50, maximum: 100))]
    private let iconOptions = [
        "star", "flame", "leaf", "drop", "bolt", "heart", "gift", "figure.walk",
        "book", "music.note", "moon", "sun.max", "cup.and.saucer", "laptopcomputer", "brain.head.profile"
    ]
    
    // MARK: Body
    var body: some View {
        Form {
            Section("Habit Name") {
                TextField("e.g., Drink Water", text: $habitName)
            }
            
            Section("Choose Icon") {
                LazyVGrid(columns: iconColumns, spacing: 16) {
                    ForEach(iconOptions, id: \.self) { icon in
                        Image(systemName: icon)
                            .symbolVariant(.fill)
                            .foregroundStyle(selectedIcon == icon ? .white : .black)
                            .font(.title2)
                            .padding(8)
                            .background(selectedIcon == icon ? .black : .clear)
                            .clipShape(Circle())
                            .onTapGesture { selectedIcon = icon }
                    }
                }
                .padding(.vertical, 8)
            }
            
            Button("Save") {
                habit.name = habitName
                habit.iconName = selectedIcon
                
                // To avoid inserting the same habit more then once.
                if !habit.isInserted {
                    modelContext.insert(habit)
                    habit.isInserted = true
                }
                
                dismiss()
            }
            .disabled(habitName.trimmingCharacters(in: .whitespaces).isEmpty)
        }
        .navigationTitle("Habit Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}





// MARK: - Preview
#Preview {
    EditHabitView(habit: Habit.sampleData[0], habitName: "", selectedIcon: "star")
}
