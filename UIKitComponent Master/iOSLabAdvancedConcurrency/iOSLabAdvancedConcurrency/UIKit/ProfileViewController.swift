//
//  ProfileViewController.swift
//  iOSLabAdvancedConcurrency
//
//  Created by Ляйсан
//

import UIKit
import UIKitComponent

final class ProfileViewController: UIViewController {
    var onFollow: (() -> Void)?
    
    private let profileView = ProfileView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(profileView)
        setupLayout()
        setupAppearance()
        bindAction()
    }
    
    private func setupAppearance() {
        view.backgroundColor = .secondarySystemBackground
    }
    
    private func setupLayout() {
        profileView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profileView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            profileView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            profileView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func bindAction() {
        profileView.followTap = { [weak self] in
            self?.onFollow?()
        }
    }
    
    func setupData(user: User, isFollowing: Bool, imageLoader: ImageLoader) {
        profileView.setData(user: user, isFollowing: isFollowing, imageLoader: imageLoader)
    }
}
