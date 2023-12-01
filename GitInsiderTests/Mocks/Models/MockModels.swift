//
//  MockModels.swift
//  GitInsiderTests
//
//  Created by Alphan Ogün on 28.11.2023.
//

import Foundation
@testable import GitInsider

//MARK: - User

var mockUser1 = User(
    login: "john_doe",
    id: 123456,
    nodeId: "abc123",
    avatarUrl: "https://example.com/avatar1.jpg",
    url: "https://api.github.com/users/john_doe",
    htmlUrl: "https://github.com/john_doe",
    followersUrl: "https://api.github.com/users/john_doe/followers",
    followingUrl: "https://api.github.com/users/john_doe/following",
    gistsUrl: "https://api.github.com/users/john_doe/gists",
    starredUrl: "https://api.github.com/users/john_doe/starred",
    name: "John Doe",
    bio: "Software Developer",
    twitterUsername: "john_doe_twitter",
    publicRepos: 20,
    publicGists: 5,
    followers: 100,
    following: 50
)

var mockUser2 = User(
    login: "jane_smith",
    id: 789012,
    nodeId: "xyz789",
    avatarUrl: "https://example.com/avatar2.jpg",
    url: "https://api.github.com/users/jane_smith",
    htmlUrl: "https://github.com/jane_smith",
    followersUrl: "https://api.github.com/users/jane_smith/followers",
    followingUrl: "https://api.github.com/users/jane_smith/following",
    gistsUrl: "https://api.github.com/users/jane_smith/gists",
    starredUrl: "https://api.github.com/users/jane_smith/starred",
    name: "Jane Smith",
    bio: "Frontend Developer",
    twitterUsername: "jane_smith_twitter",
    publicRepos: 15,
    publicGists: 3,
    followers: 80,
    following: 40
)

//MARK: - Repo

let mockRepo1 = Repo(
    id: 987654,
    name: "example-repo1",
    fullName: "john_doe/example-repo1",
    htmlUrl: "https://github.com/john_doe/example-repo1",
    description: "First example repository for unit testing purposes."
)

//MARK: - Repo

let mockRepo2 = Repo(
    id: 123456,
    name: "example-repo2",
    fullName: "john_doe/example-repo2",
    htmlUrl: "https://github.com/john_doe/example-repo2",
    description: "Second example repository for unit testing purposes."
)

//MARK: - AccessTokenResponse

let mockAccessTokenResponse = AccessTokenResponse(
    accessToken: "a1b2c3d4e5f6g7h8i9j0",
    expiresIn: 28800,
    refreshToken: "r1s2t3u4v5w6x7y8z9",
    refreshTokenExpiresIn: 604800,
    tokenType: "Bearer",
    scope: "read write"
)

//MARK: - Users

let mockUsers = Users(
    totalCount: 2,
    incompleteResults: false,
    items: [
        Item(
            login: "john_doe1",
            avatarUrl: "https://example.com/avatar1.jpg"
        ),
        Item(
            login: "john_doe2",
            avatarUrl: "https://example.com/avatar2.jpg"
        )
    ]
)




