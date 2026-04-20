//
//  ApiConfig.swift
//  iOSLabAdvancedConcurrency
//
//  Created by Ляйсан
//

import Foundation

enum ApiConfig {
    static func getApiKey() -> String? {
        return Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String
    }
}
