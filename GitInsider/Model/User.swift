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
    var nodeId: String?
    var avatarUrl: String?
    var url, htmlUrl, followersUrl: String?
    var followingUrl, gistsUrl, starredUrl: String?
    var name: String?
    var bio: String?
    var twitterUsername: String?
    var publicRepos, publicGists, followers, following: Int
}
