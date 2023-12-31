//
//  ProfileHeader.swift
//  GitInsider
//
//  Created by Alphan Ogün on 16.11.2023.
//

import UIKit
import Kingfisher
import SkeletonView

protocol ProfileHeaderDelegate: AnyObject {
    func follow(username: String)
    func unfollow(username: String)
    func editProfile()
}

class ProfileHeader: UIView {
    
    //MARK: - Properties
    
    weak var delegate: ProfileHeaderDelegate?
    
    var viewModel: ProfileHeaderViewModel? {
        didSet { configureViewModel() }
    }
    
    private lazy var profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .lightGray
        iv.setDimensions(height: 100, width: 100)
        iv.layer.cornerRadius = 100 / 2
        iv.layer.masksToBounds = true
        iv.isSkeletonable = true
        return iv
    }()
    
    private lazy var editButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setDimensions(height: 30, width: 30)
        button.backgroundColor = .clear
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.isSkeletonable = true
        
        button.addTarget(self, action: #selector(didTapEditFollowButton), for: .touchUpInside)
        
        return button
    }()
    
    private let fullnameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.isSkeletonable = true
        return label
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18)
        label.isSkeletonable = true
        return label
    }()
    
    private let bioLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        label.isSkeletonable = true
        return label
    }()
    
    private let followersLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.isSkeletonable = true
        return label
    }()
    
    private let followingLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.isSkeletonable = true
        return label
    }()
    
    private let repoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.isSkeletonable = true
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
    
    //MARK: - Actions
    
    @objc func didTapEditFollowButton() {
        guard let viewModel = viewModel else { return }
        switch viewModel.config {
        case .editProfile:
            delegate?.editProfile()
        case .notFollowing:
            delegate?.follow(username: viewModel.user.login)
            viewModel.user.followers += 1
        case .following:
            delegate?.unfollow(username: viewModel.user.login)
            viewModel.user.followers -= 1
        }
    }
    
    //MARK: - Helpers
    
    func configureViewModel() {
        showSkeletonGradientAnimation(false)
        guard let viewModel = viewModel else { return }
        profileImageView.kf.setImage(with: viewModel.profileImageUrl)
        editButton.setImage(viewModel.editButtonImage, for: .normal)
        fullnameLabel.text = viewModel.fullnameText
        usernameLabel.text = viewModel.usernameText
        bioLabel.text = viewModel.bioText
        followersLabel.text = viewModel.followerText
        followingLabel.text = viewModel.followingText
        repoLabel.text = viewModel.repoText
    }
    
    private func configureUI() {
        isSkeletonable = true
        backgroundColor = .githubGrey
        
        addSubview(editButton)
        editButton.anchor(top: topAnchor, right: rightAnchor, paddingTop: 8, paddingRight: 8)
        
        let nameStack = UIStackView(arrangedSubviews: [profileImageView, fullnameLabel, usernameLabel, bioLabel])
        nameStack.isSkeletonable = true
        nameStack.axis = .vertical
        nameStack.alignment = .center
        
        let statsStack = UIStackView(arrangedSubviews: [followersLabel, followingLabel, repoLabel])
        statsStack.axis = .horizontal
        statsStack.isSkeletonable = true
        statsStack.alignment = .center
        statsStack.distribution = .fill
        
        let stack = UIStackView(arrangedSubviews: [nameStack, statsStack])
        stack.isSkeletonable = true
        stack.axis = .vertical
        stack.spacing = 18
        
        addSubview(stack)
        stack.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor,
                     paddingTop: 24, paddingLeft: 12, paddingBottom: 24, paddingRight: 12)
        
        showSkeletonGradientAnimation(true)
    }
    
    private func showSkeletonGradientAnimation(_ value: Bool) {
        for subview in subviews {
            if subview.isSkeletonable {
                switch value {
                case true:
                    subview.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .githubGrey), transition: .crossDissolve(0.25))
                case false:
                    subview.hideSkeleton(transition: .crossDissolve(1))
                }
            }
        }
    }
}
