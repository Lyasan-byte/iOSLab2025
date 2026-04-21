//
//  ProfileControllerWrapper.swift
//  iOSLabAdvancedConcurrency
//
//  Created by Ляйсан
//

import Foundation
import SwiftUI
import UIKitComponent

struct ProfileControllerWrapper: UIViewControllerRepresentable {
    @Binding var isFollowing: Bool
    let user: User
    let imageLoader: ImageLoader
    
    func makeUIViewController(context: Context) -> some ProfileViewController {
        let viewController = ProfileViewController()
        viewController.setupData(
            user: user,
            isFollowing: isFollowing,
            imageLoader: imageLoader
        )
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        uiViewController.onFollow = {
            isFollowing.toggle()
        }
        
        uiViewController.toggleIsFollowing(isFollowing)
    }
}
