//
//  SocialView.swift
//  Undo
//
//  Created by AbdelRahman Mohammad on 10/06/2025.
//

import SwiftUI



// MARK: - Social View
struct SocialView: View {
    // MARK: Properties
    let image: String
    let url: URL
    
    // MARK: Body
    var body: some View {
        Link(destination: url) {
            ZStack {
                Image(image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32, height: 32)
                    .background(.white)
                    .clipShape(Circle())
                
                // Masks the icon's faint white edges that can appear in dark mode.
                Circle()
                    .stroke(lineWidth: 2)
                    .foregroundStyle(.black)
                    .frame(width: 31, height: 31)
            }
        }
    }
}





// MARK: - Preview
#Preview {
    SocialView(image: "instagram", url: URL(string: "https://www.google.com")!)
        //.preferredColorScheme(.dark)
}
