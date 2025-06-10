//
//  AttributionView.swift
//  Undo
//
//  Created by AbdelRahman Mohammad on 10/06/2025.
//

import SwiftUI



// MARK: - Attribution View
struct AttributionView: View {
    // MARK: Properties
    let work: String
    let author: String
    let url: URL
    
    // MARK: Body
    var body: some View {
        HStack {
            Text(work + " made by")
            Link(destination: url) {
                Text(author)
                    .bold()
            }
        }
    }
}





// MARK: - Preview
#Preview {
    AttributionView(work: "work", author: "author", url: URL(string: "https://www.google.com")!)
}
