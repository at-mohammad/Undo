//
//  ContentView.swift
//  Undo
//
//  Created by AbdelRahman Mohammad on 20/05/2025.
//

import SwiftUI



// MARK: - Content View
struct ContentView: View {
    // Stores whether the onboarding has been completed. Persists across app launches.
    @AppStorage("isFirstTimeUserExperience") private var isFirstTimeUserExperience = true
    
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
        // Like `.sheet`, but covers the entire screen.
        .fullScreenCover(isPresented: $isFirstTimeUserExperience) {
            OnboardingView(isFirstTimeUserExperience: $isFirstTimeUserExperience)
        }
        
        // for preview only! remove later!!!
        .onAppear {
            isFirstTimeUserExperience = true
        }
    }
}





// MARK: - Preview
#Preview {
    ContentView()
}
