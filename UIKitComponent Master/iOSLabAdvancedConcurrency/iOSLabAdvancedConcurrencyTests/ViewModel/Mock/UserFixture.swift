//
//  UserFixture.swift
//  iOSLabAdvancedConcurrencyTests
//
//  Created by Ляйсан
//

import Foundation
@testable import iOSLabAdvancedConcurrency

enum UserFixture {
    static func makeUser() -> User {
        let id = UUID().uuidString
        return User(
            id: id,
            firstName: "firstName\(id)",
            username: "username\(id)",
            email: "test\(id)@lays.com",
            phone: "7962064\(id)",
            age: 20,
            country: "Russia",
            job: "iOS Dev",
            company: "Lays"
        )
    }
    
    static func makeUsers(count: Int) -> [User] {
        (0..<count).map { _ in makeUser() }
    }
}
