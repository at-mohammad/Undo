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
                Section(String(localized: "Appearance")) {
                    // `Appearance.allCases`: Provided by the CaseIterable protocol.
                    // `id: \.rawValue`: Uses the unique string raw value to identify each option.
                    Picker(String(localized: "Appearance"), selection: $appearance) {
                        ForEach(Appearance.allCases, id: \.rawValue) { option in
                            Text(option.localizedName).tag(option.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section(String(localized: "Developer")) {
                    NavigationLink(String(localized: "About Me")) {
                        DeveloperDetailsView()
                            .navigationTitle(String(localized: "About Me"))
                            .navigationBarTitleDisplayMode(.inline)
                    }
                }
                
                Section(String(localized: "Resources")) {
                    Link(String(localized: "GitHub"), destination: githubURL)
                        .foregroundStyle(AppTheme.dynamicPrimary)
                }
                
                Section(String(localized: "Support")) {
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
                
                Section(String(localized: "Legal")) {
                    NavigationLink(String(localized: "Attributions")) {
                        List {
                            AttributionView(work: String(localized: "App Icon"), author: "icon wind", url: iconWindURL)
                            AttributionView(work: String(localized: "Social Media Icons"), author: "Freepik", url: freePikURL)
                        }
                        .foregroundStyle(AppTheme.dynamicPrimary)
                        .navigationTitle(String(localized: "Attributions"))
                        .navigationBarTitleDisplayMode(.inline)
                    }
                }
                
                Section {
                    VStack {
                        HStack(spacing: 4) {
                            HStack(spacing: 0) {
                                Text(String(localized: "Version"))
                                Text(":")
                            }
                            Text(appVersion)
                        }
                        Text(String(localized: "Creator"))
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
            .navigationTitle(String(localized: "About Undo"))
        }
    }
}





// MARK: - Preview
#Preview {
    AboutView()
        .preferredColorScheme(.dark)
}
