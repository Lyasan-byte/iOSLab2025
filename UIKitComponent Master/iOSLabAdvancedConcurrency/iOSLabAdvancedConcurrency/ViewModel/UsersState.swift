//
//  UsersState.swift
//  iOSLabAdvancedConcurrency
//
//  Created by Ляйсан
//

import Foundation

enum UsersState: Hashable {
    case loading
    case error(String)
    case content
    case empty
}
