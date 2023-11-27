//
//  GitHubService.swift
//  GitInsider
//
//  Created by Alphan Ogün on 10.11.2023.
//

import Foundation
import Moya

enum GitHubError: Error {
    case emptyUsername
    case followFailed
    case unfollowFailed
}

class GitHubService {
    let networkManager: NetworkManager
    
    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func exchangeToken(code: String) async throws -> AccessTokenResponse {
        let request = GitHubAPI.exchangeToken(code: code)
        return try await networkManager.request(request)
    }
    
    func getCurrentUser() async throws -> User {
        let request = GitHubAPI.getCurrentUser
        return try await networkManager.request(request)
    }
    
    func getUser(forUsername username: String) async throws -> User {
        let request = GitHubAPI.getUser(username: username)
        return try await networkManager.request(request)
    }
    
    func searchUser(forUsername username: String) async throws -> Users {
        let request = GitHubAPI.searchUser(query: username)
        return try await networkManager.request(request)
    }
    
    func checkIfUserFollowing(username: String) async throws -> Bool {
        let request = GitHubAPI.checkIfUserFollowing(username: username)
        return try await networkManager.requestIsStatusValid(request)
    }
    
    func follow(username: String) async throws {
        let request = GitHubAPI.follow(username: username)
        let success = try await networkManager.requestIsStatusValid(request)
        if success {
            return
        } else {
            throw GitHubError.followFailed
        }
    }
    
    func unfollow(username: String) async throws {
        let request = GitHubAPI.unfollow(username: username)
        let success = try await networkManager.requestIsStatusValid(request)
        if success {
            return
        } else {
            throw GitHubError.unfollowFailed
        }
    }
    
    func getUserRepos(username: String) async throws -> [Repo] {
        let request = GitHubAPI.getUserRepos(username: username)
        return try await networkManager.request(request)
    }
}
