//
//  ProfileHeaderViewModel.swift
//  GitInsider
//
//  Created by Alphan Ogün on 16.11.2023.
//

import UIKit

public enum EditButtonConfig {
    case editProfile
    case notFollowing
    case following
}

class ProfileHeaderViewModel {
    
    var user: User
    var followingStatus: Bool
    var config: EditButtonConfig
    
    var profileImageUrl: URL? {
        URL(string: user.avatarUrl ?? "")
    }
    
    var fullnameText: String {
        user.name ?? ""
    }
    
    var usernameText: String {
        user.login
    }
    
    var bioText: String {
        user.bio ?? ""
    }
    
    var followerText: String {
        "\(user.followers)\nFollowers"
    }
    
    var followingText: String {
        "\(user.following)\nFollowing"
    }
    
    var repoText: String {
        "\(user.publicRepos)\nRepositories"
    }
    
    var editButtonColor: UIColor {
        switch config {
        case .editProfile:
            return .darkGray
        case .notFollowing:
            return .darkGray
        case .following:
            return .gitHubGreen
        }
    }
    
    var editButtonText: String {
        switch config {
        case .editProfile:
            return "✎"
        case .notFollowing:
            return "✚"
        case .following:
            return "✓"
        }
        
    }
    
    init(user: User, followingStatus: Bool, config: EditButtonConfig? = nil) {
        self.user = user
        self.followingStatus = followingStatus
        self.config = config ?? (followingStatus ? .following : .notFollowing)
    }
}
