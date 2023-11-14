//
//  HomeViewModel.swift
//  GitInsider
//
//  Created by Alphan Ogün on 14.11.2023.
//

import UIKit
import Kingfisher

class HomeViewModel {
    //MARK: - Properties
    var user: User?
    let gitHubService: GitHubService
    weak var coordinator: AppCoordinator?
    
    var profileImage: UIImage? {
        UIImage.downloadImage(url: user?.avatarUrl) { image in
            return image
        }
    }
    
    //MARK: - Lifecycle
    
    init(user: User?, gitHubService: GitHubService = GitHubService()) {
        self.gitHubService = gitHubService
        self.user = user
    }
    
    //MARK: - Helpers
    
    
    
}
