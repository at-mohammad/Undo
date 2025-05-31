//
//  ContentView.swift
//  Undo
//
//  Created by AbdelRahman Mohammad on 20/05/2025.
//

import SwiftUI



// MARK: - Content View
struct ContentView: View {
    var body: some View {
        // Reference: LL#4
        TabView {
            Tab("My Habits", systemImage: "list.star") {
                MyHabitsView()
            }
            Tab("Settings", systemImage: "gearshape.fill") {
                SettingsView()
            }
        }
        .tint(.black)
        .preferredColorScheme(.light)
    }
}





// MARK: - Preview
#Preview {
    ContentView()
}
