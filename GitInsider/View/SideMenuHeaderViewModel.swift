//
//  SideMenuHeaderViewModel.swift
//  GitInsider
//
//  Created by Alphan Ogün on 13.11.2023.
//

import Foundation

import Foundation

class SideMenuHeaderViewModel {
    
    var user: User
    
    var profileImageUrl: URL? {
        URL(string: user.avatarUrl)
    }
    
    var usernameText: String {
        user.login
    }
    
    var fullnameText: String {
        user.name
    }
    
    var statsText: String {
        "followers: \(user.followers)\nfollowing: \(user.following)"
    }
    
    init(user: User) {
        self.user = user
    }
}
