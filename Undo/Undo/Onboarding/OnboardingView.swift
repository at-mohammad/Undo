//
//  OnboardingView.swift
//  Undo
//
//  Created by AbdelRahman Mohammad on 03/06/2025.
//

import SwiftUI



// MARK: - Onboarding View
struct OnboardingView: View {
    // MARK: Properties
    @Binding var isFirstTimeUserExperience: Bool
    private let pages = OnboardingPage.samplePages
    @State private var currentPageIndex = 0
    @State private var buttonTapTrigger = 0 // A dedicated trigger to isolate button haptics from swipe gestures.

    // MARK: Body
    var body: some View {
        VStack {
            // Displays onboarding pages, tracks current page
            TabView(selection: $currentPageIndex) {
                ForEach(pages.indices, id: \.self) { index in
                    SingleOnboardingView(page: pages[index])
                        .tag(index) // Links view to currentPageIndex
                        .padding(.top, 60)
                }
            }
            // Enable swipe gesture, hide page dots
            .tabViewStyle(.page(indexDisplayMode: .never))
            
            Button {
                if currentPageIndex < pages.count - 1 {
                    buttonTapTrigger += 1
                    withAnimation {
                        currentPageIndex += 1
                    }
                } else {
                    isFirstTimeUserExperience = false
                }
            } label: {
                Text(currentPageIndex < pages.count - 1 ? "Next": "Get Started")
                    .fontWeight(.semibold)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(.black)
                    .cornerRadius(10)
            }
            .padding(.horizontal, 40)
            .padding(.bottom, 50)
            .sensoryFeedback(.selection, trigger: buttonTapTrigger) // For each "Next" button tap
            .sensoryFeedback(.success, trigger: isFirstTimeUserExperience) // For the final "Get Started" tap
        }
    }
}





// MARK: - Preview
#Preview {
    OnboardingView(isFirstTimeUserExperience: .constant(true))
}
