//
//  ProfileHeaderViewModel.swift
//  GitInsider
//
//  Created by Alphan Ogün on 16.11.2023.
//

import Foundation

class ProfileHeaderViewModel {
    
    var user: User
    
    var profileImageUrl: URL? {
        URL(string: user.avatarUrl ?? "")
    }
    
    var fullnameText: String {
        user.name ?? ""
    }
    
    var usernameText: String {
        user.login ?? ""
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
    
    init(user: User) {
        self.user = user
    }
}
