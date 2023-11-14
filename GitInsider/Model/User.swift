//
//  User.swift
//  GitInsider
//
//  Created by Alphan Ogün on 13.11.2023.
//

import Foundation

// MARK: - User
struct User: Codable {
    let login: String
    let id: Int
    let nodeId: String
    let avatarUrl: String
    let url, htmlUrl, followersUrl: String
    let followingUrl, gistsUrl, starredUrl: String
    let name: String
    let bio: String
    let twitterUsername: String?
    let publicRepos, publicGists, followers, following: Int
}
