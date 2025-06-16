//
//  DeveloperDetailsView.swift
//  Undo
//
//  Created by Pixel Arabi on 04/06/2025.
//

import SwiftUI



// MARK: - DeveloperDetails View
struct DeveloperDetailsView: View {
    // MARK: Properties
    private let bioText: String = """
    I created 'undo' because I believe that changing your habits starts with a single, simple step. This app is the tool I wished I had, a minimalist way to track progress and stay motivated. I hope it helps you on your journey as much as it has helped me on mine.
    """
    
    // MARK: Body
    var body: some View {
        List {
            VStack(alignment: .center) {
                Image("PixelArabi")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 128, height: 128)
                
                Text(bioText)
                    .multilineTextAlignment(.center)
            }
        }
    }
}





// MARK: - Preview
#Preview {
    DeveloperDetailsView()
}
