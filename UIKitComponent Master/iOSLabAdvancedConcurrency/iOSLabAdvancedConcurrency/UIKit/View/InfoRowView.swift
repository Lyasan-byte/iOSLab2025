//
//  InfoRowView.swift
//  iOSLabAdvancedConcurrency
//
//  Created by Ляйсан
//

import UIKit
import UIKitComponent

final class InfoRowView: UIView {
    private let background = BackgroundView(
        backgroundColor: .userLightGray,
        cornerRadius: 25
    )
    private lazy var infoTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 11, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var info: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarchy()
        setupLayout()
    }
    
    convenience init(color: UIColor) {
        self.init(frame: .zero)
        infoTitle.textColor = color
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(title: String, text: String) {
        infoTitle.text = title
        info.text = text
    }
    
    private func setupHierarchy() {
        addSubview(background)
        addSubview(infoTitle)
        background.addSubview(info)
    }
    
    private func setupLayout() {
        translatesAutoresizingMaskIntoConstraints = false
        infoTitle.translatesAutoresizingMaskIntoConstraints = false
        info.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            infoTitle.topAnchor.constraint(equalTo: topAnchor),
            infoTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            infoTitle.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            background.topAnchor.constraint(equalTo: infoTitle.bottomAnchor, constant: 2),
            background.leadingAnchor.constraint(equalTo: leadingAnchor),
            background.trailingAnchor.constraint(equalTo: trailingAnchor),
            background.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            info.topAnchor.constraint(equalTo: background.topAnchor, constant: 16),
            info.leadingAnchor.constraint(equalTo: background.leadingAnchor, constant: 16),
            info.trailingAnchor.constraint(equalTo: background.trailingAnchor, constant: -16),
            info.bottomAnchor.constraint(equalTo: background.bottomAnchor, constant: -16)
        ])
    }
}
