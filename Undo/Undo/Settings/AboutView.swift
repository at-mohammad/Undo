//
//  AboutView.swift
//  Undo
//
//  Created by AbdelRahman Mohammad on 29/05/2025.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        List {
            Section("Developer") {
                Text("Me")
            }
            
            Section("Follow") {
                Text("TikTok")
                Text("YouTube")
                Text("Instagram")
                Text("X (Twitter)")
            }
            
            Section("Acknowledgements") {
                Text("Icon")
            }
        }
        .navigationTitle("About Undo")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    AboutView()
}
