//
//  AppInfo.swift
//  Undo
//
//  Created by AbdelRahman Mohammad on 04/06/2025.
//

import Foundation

struct AppInfo {
    static var version: String {
        Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "N/A"
    }
    
    static var buildNumber: String {
        Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? "N/A"
    }
}
