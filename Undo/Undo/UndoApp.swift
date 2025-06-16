//
//  UndoApp.swift
//  Undo
//
//  Created by Pixel Arabi on 20/05/2025.
//

import SwiftData
import SwiftUI
import TipKit

@main
struct UndoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .task {
                    try? Tips.configure([
                        .displayFrequency(.immediate),
                        .datastoreLocation(.applicationDefault)
                    ])
                }
        }
        .modelContainer(for: Habit.self)
    }
}
