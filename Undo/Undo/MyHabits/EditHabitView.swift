//
//  EditHabitView.swift
//  Undo
//
//  Created by Pixel Arabi on 26/05/2025.
//

import SwiftData
import SwiftUI



// MARK: - Edit Habit View
struct EditHabitView: View {
    // MARK: Properties
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    let habit: Habit
    @State private var habitName: String
    @State private var selectedIcon: String
    @State private var creationDate: Date
    @State private var reminderEnabled: Bool
    @State private var reminderTime: Date
    
    init(habit: Habit) {
        self.habit = habit
        self._habitName = State(initialValue: habit.name)
        self._selectedIcon = State(initialValue: habit.iconName)
        self._creationDate = State(initialValue: habit.creationDate)
        
        self._reminderEnabled = State(initialValue: habit.reminder?.isEnabled ?? false)
        self._reminderTime = State(initialValue: habit.reminder?.time ?? .now)
    }
    
    private let iconColumns = [
        GridItem(.fixed(65)),
        GridItem(.fixed(65)),
        GridItem(.fixed(65)),
        GridItem(.fixed(65)),
        GridItem(.fixed(65))
    ]
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
            
            Section("Reminders") {
                Toggle("Enable Reminders", isOn: $reminderEnabled.animation())
                if reminderEnabled {
                    DatePicker("Reminder Time", selection: $reminderTime, displayedComponents: .hourAndMinute)
                }
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
        
        habit.updateReminder(isEnabled: reminderEnabled, time: reminderTime, modelContext: modelContext)
        
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
    EditHabitView(habit: Habit.sampleData[0])
}
