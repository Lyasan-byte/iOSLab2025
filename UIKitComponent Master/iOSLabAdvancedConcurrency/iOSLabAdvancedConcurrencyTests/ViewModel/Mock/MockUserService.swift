//
//  MockUserService.swift
//  iOSLabAdvancedConcurrencyTests
//
//  Created by Ляйсан
//

import Foundation
@testable import iOSLabAdvancedConcurrency

final class MockUserService: UserRepository {
    var result: Result<[User], Error>
    var isCalled: Bool = false
    
    init(result: Result<[User], Error>) {
        self.result = result
    }
    
    func fetchUsers(from baseUrl: String, count: Int) async throws -> [User] {
        isCalled = true
        switch result {
        case .success(let user):
             return user
        case .failure(let error):
             throw error
        }
    }
}
