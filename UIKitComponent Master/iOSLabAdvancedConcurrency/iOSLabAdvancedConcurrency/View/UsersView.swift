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
            background.ignoresSafeArea()
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
            .padding(.top, 65)
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
        .scrollContentBackground(.hidden)
        .scrollIndicators(.hidden)
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
    
    @ViewBuilder private var background: some View {
        Color("backgroundColor")
        Rectangle()
            .fill(Color(.systemIndigo).opacity(0.6))
            .blur(radius: 50)
            .frame(width: 470, height: 50)
            .position(x: 220, y: 800)
    }
}

#Preview {
    NavigationStack {
        UsersView(usersViewModel: UsersViewModel(userRepository: AlamofireUserService(), userCache: DefaultUserCache()))
    }
}
