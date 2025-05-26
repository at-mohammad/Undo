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
        NavigationStack {
            MyChallengesView()
                .preferredColorScheme(.light)
        }
    }
}





// MARK: - Preview
#Preview {
    ContentView()
}
