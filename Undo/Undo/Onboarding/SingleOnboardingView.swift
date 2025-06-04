//
//  SingleOnboardingView.swift
//  Undo
//
//  Created by AbdelRahman Mohammad on 03/06/2025.
//

import SwiftUI



// MARK: - Single Onboarding View
struct SingleOnboardingView: View {
    // MARK: Properties
    let page: OnboardingPage

    // MARK: Body
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: page.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .foregroundColor(.black)
                .padding(.bottom, 30)

            Text(page.title)
                .font(.largeTitle.bold())

            Text(page.description)
                .font(.body)
                .multilineTextAlignment(.center)
                .foregroundColor(.black.opacity(0.55))
                .padding(.horizontal, 30)
            
            Spacer()
        }
    }
}





// MARK: - Preview
#Preview {
    SingleOnboardingView(page: OnboardingPage.samplePages[0])
}
