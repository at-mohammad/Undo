//
//  DeveloperDetailsView.swift
//  Undo
//
//  Created by AbdelRahman Mohammad on 04/06/2025.
//

import SwiftUI



// MARK: - DeveloperDetails View
struct DeveloperDetailsView: View {
    // MARK: Properties
    private let bioText: String = """
    \(String(localized: "Developer Bio"))
    """
    private let xURL = URL(string: "https://x.com/ATMohammad_")!
    private let bmcURL = URL(string: "https://buymeacoffee.com/amohammad")!
    
    // MARK: Body
    var body: some View {
        List {
            Section {
                VStack(alignment: .center) {
//                    Image("AMLogo")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 128, height: 128)
//                        .clipShape(
//                            Circle()
//                        )
                    
                    Text(bioText)
                        .multilineTextAlignment(.center)
                }
            }
            
            Section {
                VStack {
                    HStack(spacing: 30) {
                        SocialView(image: "twitter", url: xURL)
                        SocialView(image: "bmc", url: bmcURL)
                    }
                    .environment(\.layoutDirection, .leftToRight) // Forces a left-to-right layout, regardless of the device's language.
                }
            }
            .font(.footnote)
            .foregroundColor(.gray)
            .frame(maxWidth: .infinity, alignment: .center)
            .listRowBackground(Color.clear)
            .buttonStyle(.plain) // Disable tapping all socials buttons at once
        }
    }
}





// MARK: - Preview
#Preview {
    DeveloperDetailsView()
}
