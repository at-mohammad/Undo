//
//  DailyProgressView.swift
//  Undo
//
//  Created by AbdelRahman Mohammad on 19/01/2026.
//

import SwiftUI



// MARK: - Daily Progress View
struct DailyProgressView: View {
    // MARK: Properties
    let uncompletedCount: Int
    let totalCount: Int
    let progress: Double
    
    // MARK: Body
    var body: some View {
        HStack(spacing: 12) {
            HStack(spacing: 4) {
                Text("\(uncompletedCount) of \(totalCount)")
                Text("Undone")
                    .foregroundStyle(.cyan)
            }
            .font(.subheadline.bold())
            
            // Custom Linear Progress Bar // Reference: DD#13
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(Color.gray.opacity(0.1))
                        .frame(height: 6)
                    
                    Capsule()
                        .fill(Color.cyan)
                        .frame(width: geo.size.width * progress, height: 6)
                        .animation(.spring, value: progress)
                }
            }
            .frame(height: 6)
        }
    }
}





// MARK: - Preview
#Preview {
    DailyProgressView(uncompletedCount: 1, totalCount: 5, progress: 1/5)
}
