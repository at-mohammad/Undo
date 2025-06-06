//
//  AppInfo.swift
//  Undo
//
//  Created by AbdelRahman Mohammad on 04/06/2025.
//

import Foundation

struct AppInfo {
    static var version: String {
        // The application's version number, as defined by the `CFBundleShortVersionString` key in the Info.plist.
        // - Example: `1.0.2`
        Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "N/A"
    }
    
    static var buildNumber: String {
        // The application's build number - Example: `345` (Mostly not necessary)
        Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? "N/A"
    }
}
