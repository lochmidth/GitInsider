//
//  ProfileController.swift
//  GitInsider
//
//  Created by Alphan Ogün on 16.11.2023.
//

import UIKit

class ProfileController: UIViewController {
    //MARK: - Properties
    
    var viewModel: ProfileViewModel?
    
    private lazy var profileHeader: ProfileHeader = {
        let header = ProfileHeader()
        header.setDimensions(height: 350, width: self.view.frame.width)
        header.layer.cornerRadius = 20
        header.addShadow()
        return header
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureProfileHeader()
        configureUI()
    }
    
    //MARK: - Helpers
    
//    private func configureViewModel() {
//        guard let viewModel = viewModel else { return }
//        
//    }
    
    private func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(profileHeader)
        profileHeader.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor,
                             paddingTop: 4, paddingLeft: 18, paddingRight: 18)
    }
    
    private func configureProfileHeader() {
        guard let viewModel = viewModel else { return }
        viewModel.checkIfUserFollowing(username: viewModel.user.login) { [weak self] followingStatus in
            if viewModel.authLogin == viewModel.user.login {
                self?.profileHeader.viewModel = ProfileHeaderViewModel(user: viewModel.user, followingStatus: followingStatus, config: .editProfile)
                self?.profileHeader.delegate = self
            } else {
                self?.profileHeader.viewModel = ProfileHeaderViewModel(user: viewModel.user, followingStatus: followingStatus)
                self?.profileHeader.delegate = self
            }
        }
    }
}

extension ProfileController: ProfileHeaderDelegate {
    func follow(username: String) {
        viewModel?.follow(username: username, completion: {
            print("DEBUG: \(username) followed.")
            self.profileHeader.viewModel?.config = .notFollowing
            
            UIView.animate(withDuration: 0.5) {
                self.profileHeader.configureViewModel()
            }
        })
    }
    
    func unfollow(username: String) {
        print("DEBUG: unfollow pressed")
        viewModel?.unfollow(username: username, completion: {
            print("DEBUG: \(username) unfollowed.")
            self.profileHeader.viewModel?.config = .following
            
            UIView.animate(withDuration: 0.5) {
                self.profileHeader.configureViewModel()
            }
        })
    }
    
    func editProfile() {
        print("DEBUG: Handle Edit Profile")
    }
}
