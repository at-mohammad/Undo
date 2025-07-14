//
//  AboutView.swift
//  Undo
//
//  Created by Pixel Arabi on 29/05/2025.
//

import SwiftUI



// MARK: - About View
struct AboutView: View {
    // MARK: Properties
    private let appVersion = AppInfo.version
    private let buildNumber = AppInfo.buildNumber
    private let feedbackEmail = "pixelarabiofficial@gmail.com"
    private let githubURL = URL(string: "https://github.com/PixelArabi/Undo.git")!
    private let appReviewURL = URL(string: "https://apps.apple.com/app/id6747099055?action=write-review")!
    private let appShareURL = URL(string: "https://apps.apple.com/app/id6747099055")!
    private let tiktokURL = URL(string: "https://www.tiktok.com/@pixelarabi")!
    private let youtubeURL = URL(string: "https://www.youtube.com/@pixelarabi")!
    private let instagramURL = URL(string: "https://www.instagram.com/pixelarabi")!
    private let xURL = URL(string: "https://x.com/pixelarabi_")!
    private let bmcURL = URL(string: "https://buymeacoffee.com/pixelarabi")!
    private let iconWindURL = URL(string: "https://www.flaticon.com/authors/icon-wind")!
    private let freePikURL = URL(string: "https://www.flaticon.com/authors/freepik")!
    
    @AppStorage("appearance") private var appearance: String = Appearance.system.rawValue

    // MARK: Body
    var body: some View {
        NavigationStack {
            List {
                Section("Appearance") {
                    // `Appearance.allCases`: Provided by the CaseIterable protocol.
                    // `id: \.rawValue`: Uses the unique string raw value to identify each option.
                    Picker("Appearance", selection: $appearance) {
                        ForEach(Appearance.allCases, id: \.rawValue) { option in
                            Text(option.rawValue.capitalized)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Developer") {
                    NavigationLink("About Me") {
                        DeveloperDetailsView()
                            .navigationTitle("About Me")
                            .navigationBarTitleDisplayMode(.inline)
                    }
                }
                
                Section("Resources") {
                    Link("Source Code on GitHub", destination: githubURL)
                        .foregroundStyle(AppTheme.dynamicPrimary)
                }
                
                Section("Support") {
                    Group {
                        Link(destination: appReviewURL) {
                            Label("Leave a Review", systemImage: "star.fill")
                        }
                        ShareLink(item: appShareURL) {
                            Label("Share the App", systemImage: "square.and.arrow.up.fill")
                        }
                        Link(destination: URL(string: "mailto:\(feedbackEmail)?subject=Feedback%20for%20Undo%20App%20(v\(appVersion))")!) {
                            Label("Send Feedback", systemImage: "envelope.fill")
                        }
                    }
                    .foregroundStyle(AppTheme.dynamicPrimary)
                    
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
                        .foregroundStyle(AppTheme.dynamicPrimary)
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
                    }
                }
                .font(.footnote)
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity, alignment: .center)
                .listRowBackground(Color.clear)
                .buttonStyle(.plain) // Disable tapping all socials buttons at once
                
            }
            .navigationTitle("About Undo")
        }
    }
}





// MARK: - Preview
#Preview {
    AboutView()
        .preferredColorScheme(.dark)
}
