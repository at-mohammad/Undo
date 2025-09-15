//
//  OnboardingPage.swift
//  Undo
//
//  Created by AbdelRahman Mohammad on 03/06/2025.
//

import Foundation

struct OnboardingPage {
    // MARK: - Static Properties
    static var samplePages: [OnboardingPage] = [
        OnboardingPage(imageName: "figure.walk.circle.fill",
                       title: String(localized: "Onboarding Page Title 1"),
                       description: String(localized: "Onboarding Page Description 1")),
        OnboardingPage(imageName: "plus.circle.fill",
                       title: String(localized: "Onboarding Page Title 2"),
                       description: String(localized: "Onboarding Page Description 2")),
        OnboardingPage(imageName: "chart.bar.xaxis",
                       title: String(localized: "Onboarding Page Title 3"),
                       description: String(localized: "Onboarding Page Description 3")),
        OnboardingPage(imageName: "checkmark.seal.fill",
                       title: String(localized: "Onboarding Page Title 4"),
                       description: String(localized: "Onboarding Page Description 4"))
    ]
    
    // MARK: - Properties
    var imageName: String
    var title: String
    var description: String
}
