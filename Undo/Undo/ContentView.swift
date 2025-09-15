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
    @AppStorage("appearance") private var appearance: String = Appearance.system.rawValue
    
    private var currentScheme: ColorScheme? {
        switch Appearance(rawValue: appearance) {
        case .light: return .light
        case .dark: return .dark
        default: return nil
        }
    }
    
    var body: some View {
        // Reference: LL#4
        TabView {
            Tab(String(localized: "My Habits"), systemImage: "list.star") {
                MyHabitsView()
            }
            Tab(String(localized: "About"), systemImage: "info.circle") {
                AboutView()
            }
        }
        .tint(AppTheme.dynamicPrimary)
        .preferredColorScheme(currentScheme)
        // Like `.sheet`, but covers the entire screen.
        .fullScreenCover(isPresented: $isFirstTimeUserExperience) {
            OnboardingView(isFirstTimeUserExperience: $isFirstTimeUserExperience)
        }
    }
}





// MARK: - Preview
#Preview {
    ContentView()
}
