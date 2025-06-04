//
//  AboutView.swift
//  Undo
//
//  Created by AbdelRahman Mohammad on 29/05/2025.
//

import SwiftUI



// MARK: - About View
struct AboutView: View {
    // MARK: Properties
    private let appVersion = AppInfo.version
    private let buildNumber = AppInfo.buildNumber
    private let feedbackEmail = "pixelarabiofficial@gmail.com"
    // TODO: Replace with your actual App Id
    private let appReviewURL = URL(string: "https://apps.apple.com/app/id1523772947?action=write-review")!
    private let appShareURL = URL(string: "https://apps.apple.com/app/id1523772947")!
    private let githubURL = URL(string: "https://github.com/3BDLR7MN/Undo.git")!
    private let tiktokURL = URL(string: "https://www.tiktok.com/@pixelarabi")!
    private let youtubeURL = URL(string: "https://www.youtube.com/@pixelarabi")!
    private let instagramURL = URL(string: "https://www.instagram.com/pixelarabi")!
    private let xURL = URL(string: "https://x.com/pixelarabi_")!

    // MARK: Body
    var body: some View {
        NavigationStack {
            List {
                Section("Developer") {
                    NavigationLink("About Me") {
                        DeveloperDetailView()
                    }
                }
                
                // TODO: Uncomment if repo made public
//                Section("Resources") {
//                    Link("Source Code on GitHub", destination: githubURL)
//                }
                
                Section("Support") {
                    Link(destination: appReviewURL) {
                        Label("Leave a Review", systemImage: "star.fill")
                    }
                    ShareLink(item: appShareURL) {
                        Label("Share the App", systemImage: "square.and.arrow.up.fill")
                    }
                    Link(destination: URL(string: "mailto:\(feedbackEmail)?subject=Feedback%20for%20Undo%20App%20(v\(appVersion))")!) {
                        Label("Send Feedback", systemImage: "envelope.fill")
                    }
                    NavigationLink {
                        TipJarView()
                    } label: {
                        Label("Support with a Tip", systemImage: "heart.fill")
                    }
                }
                
                Section("Follow") {
                    Link("TikTok", destination: tiktokURL)
                    Link("YouTube", destination: youtubeURL)
                    Link("Instagram", destination: instagramURL)
                    Link("X (Twitter)", destination: xURL)
                }
                
                Section("Acknowledgements") {
                    Text("If Needed")
                }
                
                Section("App Version") {
                    Text("\(appVersion) (\(buildNumber))")
                        .foregroundColor(.gray)
                }
            }
            .navigationTitle("About Undo")
            .foregroundStyle(.black)
        }
    }
}





// MARK: - Preview
#Preview {
    AboutView()
}
