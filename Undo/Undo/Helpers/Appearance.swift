//
//  Appearance.swift
//  Undo
//
//  Created by Pixel Arabi on 10/07/2025.
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

struct AppTheme {
    static let dynamicPrimary = Color(UIColor(named: "DynamicPrimary")!)
    static let dynamicSecondary = Color(UIColor(named: "DynamicSecondary")!)
    static let dynamicAccent = Color(UIColor(named: "DynamicAccent")!)
    static let dynamicTint = Color(UIColor(named: "DynamicTint")!)
}
