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
    
    var editButtonImage: UIImage? {
        switch config {
        case .editProfile:
            return UIImage(systemName: "square.and.pencil")?.withTintColor(.gitHubWhite, renderingMode: .alwaysOriginal)
        case .notFollowing:
            return UIImage(systemName: "person.badge.plus")?.withTintColor(.gitHubGreen, renderingMode: .alwaysOriginal)
        case .following:
            return UIImage(systemName: "person.badge.minus")?.withTintColor(.gitHubRed, renderingMode: .alwaysOriginal)
        }
    }
    
    init(user: User, followingStatus: Bool, config: EditButtonConfig? = nil) {
        self.user = user
        self.followingStatus = followingStatus
        self.config = config ?? (followingStatus ? .following : .notFollowing)
    }
}
