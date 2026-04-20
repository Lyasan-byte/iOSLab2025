//
//  DefaultUserCache.swift
//  iOSLabAdvancedConcurrency
//
//  Created by Ляйсан
//

import Foundation

actor DefaultUserCache: UserCache {
    private var users: [User] = []
    
    private var hitCount = 0
    
    func getUsers() -> [User] {
        if !users.isEmpty {
            hitCount += 1
            print("Cache hit for users, hit count: \(hitCount)")
        }
        return users
    }
    
    func saveUsers(_ users: [User]) {
        self.users = users
    }
}
