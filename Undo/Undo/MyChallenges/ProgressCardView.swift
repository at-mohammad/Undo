//
//  ProgressCardView.swift
//  Undo
//
//  Created by AbdelRahman Mohammad on 20/05/2025.
//

import SwiftUI



// MARK: - Progress Card View
struct ProgressCardView: View {
    let completedCount: Int
    let totalCount: Int
    
    private var encouragementText: String {
        switch progress {
        case 1.0: return "All done! 🎉"
        case 0.75...: return "Almost there!"
        default: return "Keep it up!"
        }
    }
    
    private var progress: Double {
        Double(completedCount) / Double(totalCount)
    }

    var body: some View {
        HStack(spacing: 150) {
            VStack(alignment: .leading, spacing: 5) {
                Text(encouragementText)
                    .font(.headline)
                    .foregroundStyle(.white)
                
                Text("\(completedCount)/\(totalCount) completed")
                    .font(.subheadline)
                    .foregroundStyle(.white.opacity(0.8))
            }
            
            CircularProgressView(progress: progress)
                .frame(width: 60, height: 60)
        }
    }
}





// MARK: - Preview
#Preview {
    ProgressCardView(completedCount: 1, totalCount: 4)
}
