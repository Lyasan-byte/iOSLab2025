//
//  iOSLabAdvancedConcurrencyApp.swift
//  iOSLabAdvancedConcurrency
//
//  Created by Ляйсан
//

import SwiftUI

@main
struct iOSLabAdvancedConcurrencyApp: App {
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
