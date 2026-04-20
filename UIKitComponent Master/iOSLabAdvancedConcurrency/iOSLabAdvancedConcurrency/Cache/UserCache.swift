//
//  UserCache.swift
//  iOSLabAdvancedConcurrency
//
//  Created by Ляйсан
//

import Foundation

protocol UserCache: Actor {
    func getUsers() -> [User]
    func saveUsers(_ users: [User])
}
