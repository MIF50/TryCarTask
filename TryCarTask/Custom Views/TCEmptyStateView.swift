//
//  GFEmptyStateView.swift
//  TryCarTask
//
//  Created by Mohamed Ibrahim on 5/14/21.
//

import UIKit

class TCEmptyStateView: UIView {
    
    // MARK:- Views
    let messageLabel = TCTitleLabel(textAlignment: .center, fontSize: 28)
    let logoImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    convenience init(message: String) {
        self.init(frame: .zero)
        messageLabel.text = message
    }
    
    private func configure() {
        addSubviews(logoImageView, messageLabel)
        configureMessageLabel()
        configureImageView()
    }
    
    private func configureImageView() {
        logoImageView.image = Images.emptyState
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let logoImageViewBottomConstant: CGFloat = 40
        
        NSLayoutConstraint.activate([
            logoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: logoImageViewBottomConstant),
            logoImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            logoImageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            logoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 170)
        ])
    }
    
    private func configureMessageLabel() {
        messageLabel.numberOfLines = 3
        messageLabel.textColor = .secondaryLabel
        
        let labelCenterYConstant: CGFloat = -150
        NSLayoutConstraint.activate([
            messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            messageLabel.heightAnchor.constraint(equalToConstant: 200),
            messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: labelCenterYConstant)
        ])
    }
}

enum Images {
    static let emptyState = UIImage(named: "avatar")
}
