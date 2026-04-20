//
//  MockUserCache.swift
//  iOSLabAdvancedConcurrencyTests
//
//  Created by Ляйсан
//

import Foundation
@testable import iOSLabAdvancedConcurrency

actor MockUserCache: UserCache {
    var cachedUsers: [User]
    
    private(set) var getUsersCount: Int = 0
    private(set) var saveUsersCount: Int = 0
    
    init(cachedUsers: [User]) {
        self.cachedUsers = cachedUsers
    }
    
    func getUsers() -> [User] {
        getUsersCount += 1
        return cachedUsers
    }
    
    func saveUsers(_ users: [User]) {
        saveUsersCount += 1
        cachedUsers = users
    }
}
