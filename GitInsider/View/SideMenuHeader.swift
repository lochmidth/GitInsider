//
//  SideMenuHeader.swift
//  GitInsider
//
//  Created by Alphan Ogün on 9.11.2023.
//

import UIKit

class SideMenuHeader: UIView {
    //MARK: - Properties
    
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .githubLightGray
        iv.layer.borderWidth = 1
        iv.clipsToBounds = true
        iv.image = UIImage(named: "spiderman_profileImage")
        iv.layer.borderColor = UIColor.gitHubWhite.cgColor
        return iv
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.text = "lochmidth"
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .lightGray
        label.text = "alphanogun@gmail.com"
        return label
    }()
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        backgroundColor = .githubBlack
        
        addSubview(profileImageView)
        profileImageView.anchor(top: safeAreaLayoutGuide.topAnchor, left: leftAnchor,
                                paddingTop: 12, paddingLeft: 12, width: 64, height: 64)
        profileImageView.layer.cornerRadius = 64 / 2
        
        let stack = UIStackView(arrangedSubviews: [usernameLabel, emailLabel])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 4
        
        addSubview(stack)
        stack.centerY(inView: profileImageView, leftAnchor: profileImageView.rightAnchor, paddingLeft: 12)
    }
    
}
