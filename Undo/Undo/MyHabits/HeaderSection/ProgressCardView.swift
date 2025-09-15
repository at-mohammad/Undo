//
//  ProgressCardView.swift
//  Undo
//
//  Created by AbdelRahman Mohammad on 20/05/2025.
//

import SwiftUI



// MARK: - Progress Card View
struct ProgressCardView: View {
    // MARK: Properties
    let completedCount: Int
    let totalCount: Int
    
    // MARK: Computed Properties
    private var progress: Double {
        guard totalCount > 0 else { return 0 } // avoid division by zero
        return Double(completedCount) / Double(totalCount)
    }
    
    private var encouragementText: String {
        switch progress {
        case 1.0: return String(localized: "Progress 100%")
        case 0.75...: return String(localized: "Progress 75%")
        case 0.50...: return String(localized: "Progress 50%")
        case 0.01...: return String(localized: "Progress 25%")
        default: return String(localized: "Progress 0%")
        }
    }
    
    // MARK: Body
    var body: some View {
        HStack {
            VStack(alignment: .center, spacing: 5) {
                Text(encouragementText)
                    .font(.headline)
                    .foregroundStyle(.white)
                
                HStack(spacing: 4) {
                    Text("\(completedCount)")
                    Text("/")
                    Text("\(totalCount)")
                    Text(String(localized: "Completed"))
                }
                .font(.subheadline)
                .foregroundStyle(.white.opacity(0.8))
            }
            .frame(width: 150)
            
            Spacer()
            
            CircularProgressView(progress: progress)
                .frame(width: 60, height: 60)
        }
    }
}





// MARK: - Preview
#Preview {
    ProgressCardView(completedCount: 1, totalCount: 4)
        .preferredColorScheme(.dark)
}
