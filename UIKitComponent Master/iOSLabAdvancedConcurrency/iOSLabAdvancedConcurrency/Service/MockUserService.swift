//
//  MockUserService.swift
//  iOSLabAdvancedConcurrency
//
//  Created by Ляйсан
//

import Foundation

final class MockUserService: UserRepository {
    func fetchUsers(from baseUrl: String, count: Int) async throws -> [User] {
        try await Task.sleep(nanoseconds: 1_000_000_000)
        return User.mockUsers
    }
}
