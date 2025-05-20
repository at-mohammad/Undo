//
//  CircularProgressView.swift
//  Undo
//
//  Created by AbdelRahman Mohammad on 20/05/2025.
//

import SwiftUI



// MARK: - Circular Progress View
struct CircularProgressView: View {
    let progress: Double
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 6) // Hollow circle (lineWidth: border size)
                .opacity(0.2) // Border opacity
                .foregroundStyle(.white) // Border color
            
            Circle()
                .trim(from: 0, to: progress) // Only draw a portion (0% → progress%)
                .stroke(.white, style: StrokeStyle(lineWidth: 6, lineCap: .round)) // lineCap: .round gives the trim rounded ends.
                .rotationEffect(.degrees(-90)) // Rotate to start at top (12 o'clock), original start point is at right (3 o'clock).
                .animation(.default, value: progress)
            
            Text("\(Int(progress * 100))%")
                .font(.subheadline.bold())
                .foregroundStyle(.white)
        }
    }
}





// MARK: - Preview
#Preview {
    CircularProgressView(progress: 33.33)
}
