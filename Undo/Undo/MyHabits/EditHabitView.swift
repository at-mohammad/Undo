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
    @State var creationDate: Date
    
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
                    .submitLabel(.done)
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
            
            Section("Start Date") {
                DatePicker("First day of your habit", selection: $creationDate, in: ...Date.now, displayedComponents: .date)
            }
        }
        .navigationTitle("Habit Details")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup(placement: .primaryAction) {
                Button("Save") {
                    saveHabit()
                }
                .disabled(habitName.trimmingCharacters(in: .whitespaces).isEmpty)
            }
        }
    }
    
    // MARK: Functions
    private func saveHabit() {
        habit.name = habitName
        habit.iconName = selectedIcon
        habit.creationDate = creationDate
        
        // To avoid inserting the same habit more then once.
        if !habit.isInserted {
            modelContext.insert(habit)
            habit.isInserted = true
        }
        
        dismiss()
    }
}





// MARK: - Preview
#Preview {
    EditHabitView(habit: Habit.sampleData[0], habitName: "", selectedIcon: "star", creationDate: Date.now)
}
