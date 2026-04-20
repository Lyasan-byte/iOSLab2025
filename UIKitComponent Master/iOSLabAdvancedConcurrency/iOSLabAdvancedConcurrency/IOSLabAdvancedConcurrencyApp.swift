//
//  IOSLabAdvancedConcurrencyApp.swift
//  iOSLabAdvancedConcurrency
//
//  Created by Ляйсан
//

import SwiftUI

@main
struct IOSLabAdvancedConcurrencyApp: App {
    @State var usersViewModel = UsersViewModel(
        userRepository: AlamofireUserService(),
        userCache: DefaultUserCache()
    )
    
    var body: some Scene {
        WindowGroup {
            UsersView(usersViewModel: usersViewModel)
        }
    }
}
