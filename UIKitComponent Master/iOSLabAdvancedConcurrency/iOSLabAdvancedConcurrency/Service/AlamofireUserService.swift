//
//  AlamofireUserService.swift
//  iOSLabAdvancedConcurrency
//
//  Created by Ляйсан
//

import Alamofire
import Foundation

enum UserServiceError: Error {
    case emptyResponse
}

final class AlamofireUserService: UserRepository {
    func fetchUsers(from baseUrl: String, count: Int) async throws -> [User] {
        let users = try await AF.request(
            baseUrl,
            method: .get,
            parameters: ["count": count],
            headers: ["X-Api-Key": ApiConfig.getApiKey() ?? ""]
        )
            .validate()
            .serializingDecodable([User].self)
            .value
        
        return users
    }
}
