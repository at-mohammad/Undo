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
    private let githubURL = URL(string: "https://github.com/PixelArabi/Undo.git")!
    
    // TODO: Replace with your actual App Id
    private let appReviewURL = URL(string: "https://apps.apple.com/app/id1523772947?action=write-review")!
    private let appShareURL = URL(string: "https://apps.apple.com/app/id1523772947")!
    
    private let tiktokURL = URL(string: "https://www.tiktok.com/@pixelarabi")!
    private let youtubeURL = URL(string: "https://www.youtube.com/@pixelarabi")!
    private let instagramURL = URL(string: "https://www.instagram.com/pixelarabi")!
    private let xURL = URL(string: "https://x.com/pixelarabi_")!
    private let bmcURL = URL(string: "https://buymeacoffee.com/pixelarabi")!
    private let flatIconURL = URL(string: "https://www.flaticon.com")!
    private let iconWindURL = URL(string: "https://www.flaticon.com/authors/icon-wind")!
    private let freePikURL = URL(string: "https://www.flaticon.com/authors/freepik")!

    // MARK: Body
    var body: some View {
        NavigationStack {
            List {
                Section("Developer") {
                    NavigationLink("About Me") {
                        DeveloperDetailsView()
                            .navigationTitle("About Me")
                            .navigationBarTitleDisplayMode(.inline)
                    }
                }
                
                Section("Resources") {
                    Link("Source Code on GitHub", destination: githubURL)
                }
                
                Section("Support") {
                    // TODO: Uncomment when your own App Id is used
//                    Link(destination: appReviewURL) {
//                        Label("Leave a Review", systemImage: "star.fill")
//                    }
//                    ShareLink(item: appShareURL) {
//                        Label("Share the App", systemImage: "square.and.arrow.up.fill")
//                    }
                    Link(destination: URL(string: "mailto:\(feedbackEmail)?subject=Feedback%20for%20Undo%20App%20(v\(appVersion))")!) {
                        Label("Send Feedback", systemImage: "envelope.fill")
                    }
                    
//                    NavigationLink {
//                        TipJarView()
//                    } label: {
//                        Label("Support with a Tip", systemImage: "heart.fill")
//                    }
                    
                }
                
                Section("Legal") {
                    NavigationLink("Attributions") {
                        List {
                            AttributionView(work: "App Icon", author: "icon wind", url: iconWindURL)
                            AttributionView(work: "Social Media Icons", author: "Freepik", url: freePikURL)
                        }
                        .navigationTitle("Attributions")
                        .navigationBarTitleDisplayMode(.inline)
                    }
                }
                
                Section {
                    VStack {
                        Text("Version: \(appVersion)")
                        Text("Created with love by Pixel Arabi")
                        HStack(spacing: 25) {
                            SocialView(image: "tiktok", url: tiktokURL)
                            SocialView(image: "youtube", url: youtubeURL)
                            SocialView(image: "instagram", url: instagramURL)
                            SocialView(image: "twitter", url: xURL)
                        }
                        
                        SocialView(image: "bmc", url: bmcURL)
                            .clipShape(Circle())
                    }
                }
                .font(.footnote)
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity, alignment: .center)
                .listRowBackground(Color.clear)
                .buttonStyle(.plain) // Disable tapping all socials buttons at once
                
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
