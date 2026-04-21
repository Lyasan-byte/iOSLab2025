//
//  ProfileView.swift
//  iOSLabAdvancedConcurrency
//
//  Created by Ляйсан
//

import UIKit
import UIKitComponent

final class ProfileView: UIView {
    var followTap: (() -> Void)?
    
    private let background = BackgroundView(
        backgroundColor: .tertiarySystemBackground,
        cornerRadius: 30
    )
    
    private let profileImage: ImageView = {
        let image = ImageView()
        image.layer.cornerRadius = 70
        return image
    }()
    
    private lazy var name = createText(
        font: .systemFont(ofSize: 26, weight: .bold)
    )
    private lazy var email = createText(
        font: .systemFont(ofSize: 16, weight: .regular)
    )
    private lazy var infoStack = VStackView(
        spacing: 3,
        arrangedSubviews: [name, email]
    )
    private lazy var jobStack = VStackView(
        spacing: 16,
        arrangedSubviews: [job, company]
    )
    
    private let job = InfoRowView(color: UIColor.systemGreen)
    private let company = InfoRowView(color: UIColor.systemPurple)
    
    private let age = InfoRowView(color: UIColor.systemIndigo)
    private let country = InfoRowView(color: UIColor.systemBlue)
    
    private lazy var ageCountryStack = HStackView(
        spacing: 10,
        distribution: .fillEqually,
        arrangedSubviews: [age, country]
    )
    
    private let followButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarchy()
        setupLayout()
        configure()
    }
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(user: User, isFollowing: Bool, imageLoader: ImageLoader) {
        name.text = user.firstName
        email.text = user.email
        age.setData(title: "AGE", text: "\(user.age) years old")
        country.setData(title: "COUNTRY", text: user.country)
        job.setData(title: "JOB", text: user.job)
        company.setData(title: "COMPANY", text: user.company)
        
        profileImage.setImage(url: "https://api.api-ninjas.com/v1/randomimage", cacheKey: user.id, imageLoader: imageLoader)
        configureButton(isFollowing)
    }
    
    func toggleIsFollowing(_ isFollowing: Bool) {
        configureButton(isFollowing)
    }
    
    private func setupHierarchy() {
        addSubview(background)
        background.addSubview(profileImage)
        background.addSubview(infoStack)
        background.addSubview(ageCountryStack)
        background.addSubview(jobStack)
        addSubview(followButton)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            background.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            background.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            profileImage.topAnchor.constraint(equalTo: background.topAnchor, constant: 26),
            profileImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            profileImage.widthAnchor.constraint(equalToConstant: 140),
            profileImage.heightAnchor.constraint(equalToConstant: 140),
            
            infoStack.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 26),
            infoStack.leadingAnchor.constraint(equalTo: background.leadingAnchor, constant: 16),
            infoStack.trailingAnchor.constraint(equalTo: background.trailingAnchor, constant: -16),
            
            ageCountryStack.topAnchor.constraint(equalTo: infoStack.bottomAnchor, constant: 26),
            ageCountryStack.leadingAnchor.constraint(equalTo: background.leadingAnchor, constant: 16),
            ageCountryStack.trailingAnchor.constraint(equalTo: background.trailingAnchor, constant: -16),
            
            jobStack.topAnchor.constraint(equalTo: ageCountryStack.bottomAnchor, constant: 16),
            jobStack.leadingAnchor.constraint(equalTo: background.leadingAnchor, constant: 16),
            jobStack.trailingAnchor.constraint(equalTo: background.trailingAnchor, constant: -16),
            jobStack.bottomAnchor.constraint(equalTo: background.bottomAnchor, constant: -26),
            
            followButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            followButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            followButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            followButton.heightAnchor.constraint(equalToConstant: 52)
        ])
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        background.translatesAutoresizingMaskIntoConstraints = false
        followButton.translatesAutoresizingMaskIntoConstraints = false
        
        followButton.addTarget(self, action: #selector(handleFollow), for: .touchUpInside)
    }
    
    private func configureButton(_ isFollowing: Bool) {
        var configuration = UIButton.Configuration.filled()
        var titleAttributes = AttributeContainer()
        titleAttributes.font = .systemFont(ofSize: 20, weight: .medium)
        
        let text = isFollowing ? "Unfollow" : "Follow"
        configuration.attributedTitle = AttributedString(text, attributes: titleAttributes)
        configuration.baseForegroundColor = isFollowing ? .black : .white
        configuration.cornerStyle = .capsule        

        configuration.baseBackgroundColor = isFollowing ? UIColor.lightGray.withAlphaComponent(0.7) : .systemIndigo
        followButton.configuration = configuration
    }
    
    @objc
    private func handleFollow() {
        followTap?()
    }
    
    private func createText(font: UIFont, color: UIColor = .label) -> UILabel {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = font
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
}
