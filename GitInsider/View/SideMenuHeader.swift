//
//  SideMenuHeader.swift
//  GitInsider
//
//  Created by Alphan Ogün on 9.11.2023.
//

import UIKit
import Kingfisher

class SideMenuHeader: UIView {
    //MARK: - Properties
    
    var viewModel: SideMenuHeaderViewModel? {
        didSet { configureViewModel() }
    }
    
    private lazy var profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .githubLightGray
        iv.layer.borderWidth = 1
        iv.clipsToBounds = true
        iv.layer.borderColor = UIColor.gitHubWhite.cgColor
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapProfileImage))
        iv.addGestureRecognizer(tap)
        iv.isUserInteractionEnabled = true
        
        return iv
    }()
    
    private let fullnameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .githubLightGray
        label.text = "Loading..."
        return label
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = .githubLightGray
        label.text = "Loading..."
        return label
    }()
    
    private let statsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = .lightGray
        label.numberOfLines = 2
        label.text = "Loading..."
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
    
    @objc func didTapProfileImage() {
        print("DEBUG: Did tap profile image.")
    }
    
    //MARK: - Helpers
    
    func configureViewModel() {
        guard let viewModel else { return }
        profileImageView.kf.setImage(with: viewModel.profileImageUrl)
        usernameLabel.text = viewModel.usernameText
        statsLabel.text = viewModel.statsText
        
        if viewModel.user.name == "" {
            fullnameLabel.isHidden = true
        } else {
            fullnameLabel.text = viewModel.fullnameText
        }
    }
    
    func configureUI() {
        backgroundColor = .githubGrey
        
        profileImageView.setDimensions(height: 64, width: 64)
        profileImageView.layer.cornerRadius = 64 / 2
        
        let stack = UIStackView(arrangedSubviews: [profileImageView, fullnameLabel, usernameLabel, statsLabel])
        stack.axis = .vertical
        stack.alignment = .leading
        stack.spacing = 3
        
        addSubview(stack)
        stack.anchor(top: topAnchor, left: leftAnchor,
                     paddingTop: 8, paddingLeft: 20)
        
        let divider = UIView()
        divider.backgroundColor = .white
        
        addSubview(divider)
        divider.anchor(left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingLeft: 10, height: 0.5)
    }
    
}
