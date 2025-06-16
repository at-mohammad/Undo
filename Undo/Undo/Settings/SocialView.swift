//
//  SocialView.swift
//  Undo
//
//  Created by Pixel Arabi on 10/06/2025.
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
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(width: 32, height: 32)
        }
    }
}





// MARK: - Preview
#Preview {
    SocialView(image: "twitter", url: URL(string: "https://www.google.com")!)
}
