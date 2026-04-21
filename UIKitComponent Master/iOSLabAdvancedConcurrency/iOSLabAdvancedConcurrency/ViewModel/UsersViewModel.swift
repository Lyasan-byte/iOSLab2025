//
//  UsersViewModel.swift
//  iOSLabAdvancedConcurrency
//
//  Created by Ляйсан
//

import SwiftUI

@MainActor
@Observable
final class UsersViewModel {
    var searchText = ""
    var state: UsersState = .loading
    var users: [User] = []
    
    private let userRepository: UserRepository
    private let userCache: UserCache
    private let url = "https://api.api-ninjas.com/v2/randomuser"
    
    private var fetchingTask: Task<Void, Never>?
        
    init(userRepository: UserRepository, userCache: UserCache) {
        self.userRepository = userRepository
        self.userCache = userCache
    }
    
    func obtainUsers() {
        fetchingTask?.cancel()
        
        fetchingTask = Task { [weak self] in
            guard let self else { return }
            await self.loadUsers()
        }
    }
    
    func loadUsers() async {
        self.state = .loading
        let cachedUsers = await userCache.getUsers()
        
        do {
            if !cachedUsers.isEmpty {
                self.users = cachedUsers
                self.state = .content
            } else {
                let users = try await userRepository.fetchUsers(from: url, count: 20)
                self.users = users
                await userCache.saveUsers(users)
                
                self.state = users.isEmpty ? .empty : .content
            }
        } catch {
            self.state = .error(error.localizedDescription)
        }
    }
    
    func loadUsersWithTaskGroup() async {
        self.state = .loading
        let cachedUsers = await userCache.getUsers()
        
        do {
            if !cachedUsers.isEmpty {
                self.users = cachedUsers
            } else {
                let users = try await withThrowingTaskGroup(
                    of: User.self,
                    returning: [User].self
                ) { group in
                    
                    for _ in 1...10 {
                        group.addTask {
                            let users = try await self.userRepository.fetchUsers(
                                from: self.url, count: 1
                            )
                            guard let user = users.first else {
                                throw URLError(.badServerResponse)
                            }
                            return user
                        }
                    }
                    var users: [User] = []
                    for try await user in group {
                        users.append(user)
                    }
                    return users
                }
                self.users = users
                await userCache.saveUsers(users)
            }
            self.state = .content
        } catch {
            self.state = .error(error.localizedDescription)
        }
    }
}
