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
                       title: "Welcome to Undo!",
                       description: "Start building positive habits and track your progress effortlessly."),
        OnboardingPage(imageName: "plus.circle.fill",
                       title: "Add & Customize",
                       description: "Easily create new habits and personalize them with a variety of icons."),
        OnboardingPage(imageName: "chart.bar.xaxis",
                       title: "Visualize Your Journey",
                       description: "See your daily and weekly progress at a glance to stay motivated."),
        OnboardingPage(imageName: "checkmark.seal.fill",
                       title: "Ready to Begin?",
                       description: "Tap 'Get Started' to take the first step towards a more productive you.")
    ]
    
    // MARK: - Properties
    var imageName: String
    var title: String
    var description: String
}
