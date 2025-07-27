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
    \(String(localized: "Developer Bio"))
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
