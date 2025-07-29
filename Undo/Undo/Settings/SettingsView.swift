//
//  SettingsView.swift
//  Undo
//
//  Created by Pixel Arabi on 28/05/2025.
//

import SwiftUI



// MARK: - Settings View
struct SettingsView: View {
    // MARK: Properties
    @AppStorage("appearance") private var appearance: String = Appearance.system.rawValue
    
    // MARK: Body
    var body: some View {
        NavigationStack {
            List {
                Section("Appearance") {
                    Picker(String(localized: "Appearance"), selection: $appearance) {
                        ForEach(Appearance.allCases, id: \.rawValue) { option in
                            Text(option.localizedName).tag(option.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Language") {
                    Button {
                        // Opens the app's settings in the iOS Settings app
                        if let url = URL(string: UIApplication.openSettingsURLString) {
                            UIApplication.shared.open(url)
                        }
                    } label: {
                        HStack {
                            Text(String(localized: "Change Language"))
                            Spacer()
                            Image(systemName: "chevron.forward")
                                .font(.caption.bold())
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            }
        }
    }
}





// MARK: - Preview
#Preview {
    SettingsView()
}
