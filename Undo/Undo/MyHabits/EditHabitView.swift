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
    @State private var habitName: String
    @State private var selectedIcon: String
    @State private var creationDate: Date
    @State private var reminderEnabled: Bool
    @State private var reminderTime: Date
    
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
    
    // MARK: Initialization
    // Reference: DD#7
    init(habit: Habit) {
        self.habit = habit
        self._habitName = State(initialValue: habit.name)
        self._selectedIcon = State(initialValue: habit.iconName)
        self._creationDate = State(initialValue: habit.creationDate)
        
        self._reminderEnabled = State(initialValue: habit.reminder?.isEnabled ?? false)
        self._reminderTime = State(initialValue: habit.reminder?.time ?? .now)
    }
    
    // MARK: Body
    var body: some View {
        Form {
            Section(String(localized: "Habit Name")) {
                TextField(String(localized: "Habit Name Example"), text: $habitName)
                    .submitLabel(.done)
            }
            
            Section(String(localized: "Choose Icon")) {
                LazyVGrid(columns: iconColumns, spacing: 16) {
                    ForEach(iconOptions, id: \.self) { icon in
                        Image(systemName: icon)
                            .symbolVariant(.fill)
                            .foregroundStyle(selectedIcon == icon ? AppTheme.dynamicSecondary : AppTheme.dynamicPrimary)
                            .font(.title2)
                            .padding(8)
                            .background(selectedIcon == icon ? AppTheme.dynamicPrimary : .clear)
                            .clipShape(Circle())
                            .onTapGesture { selectedIcon = icon }
                    }
                }
                .padding(.vertical, 8)
            }
            
            Section(String(localized: "Start Date")) {
                DatePicker(String(localized: "Habit First Day"), selection: $creationDate, in: ...Date.now, displayedComponents: .date)
            }
            
            Section(String(localized: "Reminders")) {
                Toggle(String(localized: "Enable Reminders"), isOn: $reminderEnabled.animation())
                    .tint(.blue)
                    .onChange(of: reminderEnabled) { oldValue, newValue in
                        // Only request permission when the toggle is turned ON
                        if newValue == true {
                            NotificationManager.instance.requestAuthorization()
                        }
                    }
                
                if reminderEnabled {
                    DatePicker(String(localized: "Reminder Time"), selection: $reminderTime, displayedComponents: .hourAndMinute)
                }
            }
        }
        .navigationTitle(String(localized: "Habit Details"))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup(placement: .primaryAction) {
                Button(String(localized: "Save")) {
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
        
        // Explicitly save changes to the database immediately.
        // This prevents a condition where deleting a habit right after saving it
        // could cause it to revert to its previous state instead of deleting.
        try? modelContext.save()
        
        dismiss()
    }
}





// MARK: - Preview
#Preview {
    EditHabitView(habit: Habit.sampleData[0])
        .preferredColorScheme(.dark)
}
