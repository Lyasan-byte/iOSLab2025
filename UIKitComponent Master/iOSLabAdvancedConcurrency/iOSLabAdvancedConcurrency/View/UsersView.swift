//
//  UsersView.swift
//  iOSLabAdvancedConcurrency
//
//  Created by Ляйсан
//

import SwiftUI

struct UsersView: View {
    @Bindable var usersViewModel: UsersViewModel
    @State private var isFollowing = false
    
    init(usersViewModel: UsersViewModel) {
        self.usersViewModel = usersViewModel
    }
    
    var body: some View {
        NavigationStack {
            contentView
        }
        .task {
            usersViewModel.obtainUsers()
        }
    }
    
    @ViewBuilder private var contentView: some View {
        switch usersViewModel.state {
        case .loading:
            ProgressView()
        case .error(let error):
            Text(error)
                .multilineTextAlignment(.center)
                .padding()
        case .content:
            usersView
        case .empty:
            ContentUnavailableView("No Users", image: "person.2.fill")
        }
    }
    
    private var usersView: some View {
        ZStack {
            Color(.secondarySystemBackground).ignoresSafeArea()
            VStack(spacing: 10) {
                Text("Users")
                    .font(.system(size: 30, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)
                usersList
                    .refreshable {
                        usersViewModel.obtainUsers()
                    }
            }
            .padding(.top, 70)
        }
    }
    
    private var usersList: some View {
        List {
            ForEach(usersViewModel.users) { user in
                NavigationLink {
                    ProfileControllerWrapper(
                        isFollowing: $isFollowing,
                        user: user,
                        imageLoader: AlamofireImageLoaderService()
                    ).ignoresSafeArea()
                } label: {
                    userInfo(for: user)
                }
            }
        }
        .navigationLinkIndicatorVisibility(.hidden)
    }
    
    private func userInfo(for user: User) -> some View {
        HStack(alignment: .bottom) {
            VStack(alignment: .leading) {
                Text(user.firstName)
                    .fontWeight(.semibold)
                Text("@\(user.username)")
                    .font(.subheadline)
                    .foregroundStyle(Color.colors.randomElement() ?? .black)
            }
            Spacer()
            Text(user.phone)
                .font(.subheadline)
        }
    }
}

#Preview {
    UsersView(usersViewModel: UsersViewModel(userRepository: AlamofireUserService(), userCache: DefaultUserCache()))
}
