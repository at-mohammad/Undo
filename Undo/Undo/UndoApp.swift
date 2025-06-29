//
//  UndoApp.swift
//  Undo
//
//  Created by Pixel Arabi on 20/05/2025.
//

import SwiftData
import SwiftUI
import TipKit // Reference: DD#8

@main
struct UndoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    NotificationManager.instance.requestAuthorization()
                }
                .task {
                    try? Tips.configure([
                        .displayFrequency(.immediate), // Show tips immediately
                        .datastoreLocation(.applicationDefault) // Store TipKit data in the default location
                    ])
                }
        }
        .modelContainer(for: Habit.self)
    }
}
