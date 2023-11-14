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
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .lightGray
        label.text = "Loading..."
        return label
    }()
    
    private let fullnameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .lightGray
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
        
        if viewModel.user.name == "" {
            fullnameLabel.isHidden = true
        } else {
            fullnameLabel.text = viewModel.fullnameText
        }
    }
    
    func configureUI() {
        backgroundColor = .githubGrey
        
        addSubview(profileImageView)
        profileImageView.anchor(top: safeAreaLayoutGuide.topAnchor, left: leftAnchor,
                                paddingTop: 12, paddingLeft: 12, width: 64, height: 64)
        profileImageView.layer.cornerRadius = 64 / 2
        
        let stack = UIStackView(arrangedSubviews: [usernameLabel, fullnameLabel])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 4
        
        addSubview(stack)
        stack.centerY(inView: profileImageView, leftAnchor: profileImageView.rightAnchor, paddingLeft: 12)
    }
    
}
