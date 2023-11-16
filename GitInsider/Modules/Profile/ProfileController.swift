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
        guard let user = viewModel?.user else { return }
        profileHeader.viewModel = ProfileHeaderViewModel(user: user)
    }
}
