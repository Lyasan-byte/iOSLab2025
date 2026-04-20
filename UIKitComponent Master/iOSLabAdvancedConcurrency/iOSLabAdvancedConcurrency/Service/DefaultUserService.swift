//
//  DefaultUserService.swift
//  iOSLabAdvancedConcurrency
//
//  Created by Ляйсан
//

import Foundation

final class DefaultUserService: UserRepository {
    private let urlSession: URLSession
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    func fetchUsers(from baseUrl: String, count: Int) async throws -> [User] {
        guard
            var components = URLComponents(string: baseUrl),
            let scheme = components.scheme,
            let host = components.host,
            !scheme.isEmpty,
            !host.isEmpty
        else {
            throw URLError(.badURL)
        }
        
        components.queryItems = [
            URLQueryItem(name: "count", value: "\(count)")
        ]
        
        guard let url = components.url else {
            throw URLError(.badURL)
        }
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "GET"
        urlRequest.setValue(ApiConfig.getApiKey(), forHTTPHeaderField: "X-Api-Key")
        
        let (data, response) = try await urlSession.data(for: urlRequest)
        try handleResponse(data: data, response: response)
        
        return try JSONDecoder().decode([User].self, from: data)
    }
    
    private func handleResponse(data: Data, response: URLResponse) throws  {
        guard let response = response as? HTTPURLResponse,
              (200..<300).contains(response.statusCode)
        else { throw URLError(.badServerResponse) }
    }
}
