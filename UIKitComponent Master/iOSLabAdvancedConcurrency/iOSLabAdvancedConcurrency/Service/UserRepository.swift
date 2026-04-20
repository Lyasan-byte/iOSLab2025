//
//  UserRepository.swift
//  iOSLabAdvancedConcurrency
//
//  Created by Ляйсан
//

import Foundation

protocol UserRepository {
    func fetchUsers(from baseUrl: String, count: Int) async throws -> [User]
}
