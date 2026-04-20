//
//  UsersViewModelTests.swift
//  iOSLabAdvancedConcurrencyTests
//
//  Created by Ляйсан
//

import Foundation
import Testing

@testable import iOSLabAdvancedConcurrency

@MainActor
struct UsersViewModelTests {
    
    @Test
    func loadUsers_withEmptyCache_shouldLoadUsers() async throws {
        let users = UserFixture.makeUsers(count: 5)
        let mockService = MockUserService(result: .success(users))
        let mockCache = MockUserCache(cachedUsers: [])
        
        let viewModel = UsersViewModel(
            userRepository: mockService,
            userCache: mockCache
        )
        
        await viewModel.loadUsers()
        
        #expect(viewModel.state == .content)
        #expect(viewModel.users == users)
        #expect(mockService.isCalled)
        #expect(await mockCache.cachedUsers == users)
        #expect(await mockCache.saveUsersCount == 1)
    }
    
    @Test
    func loadUsers_shouldReturnUsersFromCache() async throws {
        let users = UserFixture.makeUsers(count: 10)
        let cache = MockUserCache(cachedUsers: users)
        
        let viewModel = UsersViewModel(
            userRepository: MockUserService(result: .success([])),
            userCache: cache
        )
        
        await viewModel.loadUsers()
        
        #expect(viewModel.state == .content)
        #expect(viewModel.users == users)
        #expect(await cache.getUsersCount == 1)
    }
    
    @Test
    func loadUsers_shouldShowEmptyState_whenNoUsersInCacheAndRepository() async throws {
        let mockService = MockUserService(result: .success([]))
        let mockCache = MockUserCache(cachedUsers: [])
        
        let viewModel = UsersViewModel(
            userRepository: mockService,
            userCache: mockCache
        )
        
        await viewModel.loadUsers()
        
        #expect(viewModel.state == .empty)
        #expect(viewModel.users.isEmpty)
        #expect(await mockCache.cachedUsers.isEmpty)
    }
    
    @Test
    func loadUsers_shouldShowErrorState() async throws {
        let mockService = MockUserService(result: .failure(URLError(.badURL)))
        let mockCache = MockUserCache(cachedUsers: [])
        
        let viewModel = UsersViewModel(
            userRepository: mockService,
            userCache: mockCache
        )
        
        await viewModel.loadUsers()
        
        #expect(viewModel.state == .error(URLError(.badURL).localizedDescription))
        #expect(viewModel.users.isEmpty)
        #expect(await mockCache.getUsersCount == 1)
    }
}
