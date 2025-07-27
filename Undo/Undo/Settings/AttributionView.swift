//
//  AttributionView.swift
//  Undo
//
//  Created by Pixel Arabi on 10/06/2025.
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
            Link(destination: url) {
                // To apply different styling to parts of a single line of text, we combine multiple `Text` views using the `+` operator.
                // This allows us to apply the `.bold()` modifier only to the author's name,while the rest of the text remains in the default style.
                (Text(work + " \(String(localized: "Made By")) ") + Text(author).bold())
            }
        }
    }
}





// MARK: - Preview
#Preview {
    AttributionView(work: "work", author: "author", url: URL(string: "https://www.google.com")!)
}
