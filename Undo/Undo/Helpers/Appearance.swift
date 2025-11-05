//
//  Appearance.swift
//  Undo
//
//  Created by AbdelRahman Mohammad on 10/07/2025.
//

import Foundation
import SwiftUI

// CaseIterable Exposes an `allCases` collection to dynamically create UI, like a picker.
enum Appearance: String, CaseIterable {
    case system
    case light
    case dark
    
    var localizedName: String {
        switch self {
        case .system:
            return String(localized: "System")
        case .light:
            return String(localized: "Light")
        case .dark:
            return String(localized: "Dark")
        }
    }
}

private enum AppThemeColor {
    static func color(named name: String) -> Color {
        guard let uiColor = UIColor(named: name) else {
            assertionFailure("Missing expected color asset named \(name)")
            return Color.accentColor
        }

        return Color(uiColor)
    }
}

struct AppTheme {
    static let dynamicPrimary = AppThemeColor.color(named: "DynamicPrimary")
    static let dynamicSecondary = AppThemeColor.color(named: "DynamicSecondary")
    static let dynamicAccent = AppThemeColor.color(named: "DynamicAccent")
    static let dynamicTint = AppThemeColor.color(named: "DynamicTint")
}
