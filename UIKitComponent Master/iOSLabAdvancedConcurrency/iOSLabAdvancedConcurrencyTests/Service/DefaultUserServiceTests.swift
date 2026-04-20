//
//  DefaultUserServiceTests.swift
//  iOSLabAdvancedConcurrencyTests
//
//  Created by Ляйсан
//

import Foundation
import Testing
@testable import iOSLabAdvancedConcurrency

final class DefaultUserServiceTests {
    
    @Test
    func fetchUsers_shouldReturnDecodedUsers() async throws {
        let expectedUsers = UserFixture.makeUsers(count: 3)
        let data = try JSONEncoder().encode(expectedUsers)
        
        MockURLProtocol.requestHandler = { request in
            let url = try #require(request.url)
            
            let response = try #require(
                HTTPURLResponse(
                    url: url,
                    statusCode: 200,
                    httpVersion: nil,
                    headerFields: nil
                )
            )
            return (response, data)
        }
        
        let service = DefaultUserService(urlSession: makeURLSession())
        let users = try await service.fetchUsers(
            from: "https://api.api-ninjas.com/v2/randomuser",
            count: 3
        )
        
        #expect(users == expectedUsers)
    }
    
    @Test
    func fetchUsers_shouldThrowBadServerResponse_whenStatusCodeIsNot2xx() async throws {
        let expectedUsers = UserFixture.makeUsers(count: 2)
        let data = try JSONEncoder().encode(expectedUsers)
        
        MockURLProtocol.requestHandler = { request in
            let url = try #require(request.url)
            
            let response = try #require(
                HTTPURLResponse(
                    url: url,
                    statusCode: 500,
                    httpVersion: nil,
                    headerFields: nil
                )
            )
            return (response, data)
        }
        
        let service = DefaultUserService(urlSession: makeURLSession())
        
        do {
            _ = try await service.fetchUsers(
                from: "https://api.api-ninjas.com/v2/randomuser",
                count: 2
            )
        } catch let error as URLError {
            #expect(error.code == .badServerResponse)
        }
    }
    
    @Test
    func fetchUsers_shouldThrowBadURL_whenBaseUrlIsInvalid() async throws {
        let service = DefaultUserService(urlSession: makeURLSession())
        
        do {
            _ = try await service.fetchUsers(from: "invalid-url", count: 2)
        } catch let error as URLError {
            #expect(error.code == .badURL)
        }
    }
    
    private func makeURLSession() -> URLSession {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        return URLSession(configuration: configuration)
    }
}
