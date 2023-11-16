//
//  ProfileHeader.swift
//  GitInsider
//
//  Created by Alphan Ogün on 16.11.2023.
//

import UIKit
import Kingfisher

class ProfileHeader: UIView {
    
    //MARK: - Properties
    
    var viewModel: ProfileHeaderViewModel? {
        didSet { configureViewModel() }
    }
    
    private lazy var profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .lightGray
        iv.setDimensions(height: 100, width: 100)
        iv.layer.cornerRadius = 100 / 2
        iv.layer.masksToBounds = true
        return iv
    }()
    
    private let editButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setDimensions(height: 30, width: 30)
        button.layer.cornerRadius = 30 / 2
        button.backgroundColor = .lightGray
        return button
    }()
    
    private let fullnameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 30)
        return label
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    private let bioLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private let followersLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    private let followingLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    private let repoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
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
    
    private func configureViewModel() {
        guard let viewModel = viewModel else { return }
        profileImageView.kf.setImage(with: viewModel.profileImageUrl)
        fullnameLabel.text = viewModel.fullnameText
        usernameLabel.text = viewModel.usernameText
        bioLabel.text = viewModel.bioText
        followersLabel.text = viewModel.followerText
        followingLabel.text = viewModel.followingText
        repoLabel.text = viewModel.repoText
    }
    
    private func configureUI() {
        backgroundColor = .githubGrey
        
        addSubview(editButton)
        editButton.anchor(top: topAnchor, right: rightAnchor, paddingTop: 4, paddingRight: 4)
        
        let nameStack = UIStackView(arrangedSubviews: [profileImageView, fullnameLabel, usernameLabel, bioLabel])
        nameStack.axis = .vertical
        nameStack.alignment = .center
        
        let statsStack = UIStackView(arrangedSubviews: [followersLabel, followingLabel, repoLabel])
        statsStack.axis = .horizontal
        statsStack.alignment = .center
        statsStack.distribution = .fill
        
        let stack = UIStackView(arrangedSubviews: [nameStack, statsStack])
        stack.axis = .vertical
        stack.spacing = 18
        
        addSubview(stack)
        stack.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor,
                     paddingTop: 24, paddingLeft: 12, paddingBottom: 24, paddingRight: 12)
    }
}
