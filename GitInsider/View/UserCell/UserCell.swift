//
//  UserCell.swift
//  GitInsider
//
//  Created by Alphan Ogün on 15.11.2023.
//

import UIKit
import Kingfisher

class UserCell: UICollectionViewCell {
    //MARK: - Properties
    
    var viewModel: UserCellViewModel? {
        didSet { configureViewModel() }
    }
    
    private lazy var profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .lightGray
        iv.layer.borderColor = UIColor.white.cgColor
        iv.layer.borderWidth = 2
        iv.setDimensions(height: 80, width: 80)
        iv.layer.cornerRadius = 80 / 2
        iv.layer.masksToBounds = true
        return iv
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Username"
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
    
    private func configureUI() {
        
        let stack = UIStackView(arrangedSubviews: [profileImageView, usernameLabel])
        stack.axis = .vertical
        stack.alignment = .center
//        stack.spacing = 1
        
        contentView.addSubview(stack)
        stack.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 8, paddingLeft: 2)
    }
    
    private func configureViewModel() {
        guard let viewModel = viewModel else { return }
        profileImageView.kf.setImage(with: viewModel.profileImageUrl)
        usernameLabel.text = viewModel.usernameText
        usernameLabel.font = UIFont.boldSystemFont(ofSize: viewModel.calculateFontSize(for: usernameLabel.text, self))
    }
}
