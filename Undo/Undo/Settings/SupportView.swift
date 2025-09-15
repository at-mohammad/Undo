//
//  SupportView.swift
//  Undo
//
//  Created by AbdelRahman Mohammad on 29/07/2025.
//

import SwiftUI



// MARK: - Settings View
struct SupportView: View {
    // MARK: Properties
    private let appVersion = AppInfo.version
    private let buildNumber = AppInfo.buildNumber
    private let feedbackEmail = "atmohammad97@gmail.com"
    private let appReviewURL = URL(string: "https://apps.apple.com/app/id6747099055?action=write-review")!
    private let appShareURL = URL(string: "https://apps.apple.com/app/id6747099055")!
    
    // MARK: Body
    var body: some View {
        NavigationStack {
            List {
                Group {
                    Link(destination: appReviewURL) {
                        Label(String(localized: "Review"), systemImage: "star.fill")
                    }
                    ShareLink(item: appShareURL) {
                        Label(String(localized: "Share"), systemImage: "square.and.arrow.up.fill")
                    }
                    Link(destination: URL(string: "mailto:\(feedbackEmail)?subject=Feedback%20for%20Undo%20App%20(v\(appVersion))")!) {
                        Label(String(localized: "Feedback"), systemImage: "envelope.fill")
                    }
                }
                .foregroundStyle(AppTheme.dynamicPrimary)
                
                //                    NavigationLink {
                //                        TipJarView()
                //                    } label: {
                //                        Label("Support with a Tip", systemImage: "heart.fill")
                //                    }
            }
        }
    }
}





// MARK: - Preview
#Preview {
    SupportView()
}
