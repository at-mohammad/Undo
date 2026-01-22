//
//  DateHeaderView.swift
//  Undo
//
//  Created by AbdelRahman Mohammad on 19/01/2026.
//

import SwiftUI



// MARK: - Date Header View
struct DateHeaderView: View {
    // MARK: Properties
    let date: Date
    
    // MARK: Body
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(date.formatted(.dateTime.weekday(.wide))) // Tuesday // Reference: LL#7
                .foregroundStyle(.primary)
            
            Text(date.formatted(.dateTime.month().day())) // Oct 24 // Reference: LL#7
                .foregroundStyle(.gray.opacity(0.5))
        }
        .font(.largeTitle.bold())
    }
}





// MARK: - Preview
#Preview {
    DateHeaderView(date: .now)
}
