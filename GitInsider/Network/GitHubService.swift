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

protocol GitHubServicing {
    func exchangeToken(code: String) async throws -> AccessTokenResponse
    func getCurrentUser() async throws -> User
    func getUser(forUsername username: String) async throws -> User
    func searchUser(forUsername username: String) async throws -> Users
    func getUserRepos(username: String) async throws -> [Repo]
    func checkIfUserFollowing(username: String) async throws -> Bool
    func follow(username: String) async throws
    func unfollow(username: String) async throws
}

class GitHubService: GitHubServicing {
    let networkManager: NetworkManaging
    
    init(networkManager: NetworkManaging = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func exchangeToken(code: String) async throws -> AccessTokenResponse {
        let request = GitHubAPI.exchangeToken(code: code)
        do {
            return try await networkManager.request(request)
        } catch {
            throw error
        }
    }
    
    func getCurrentUser() async throws -> User {
        let request = GitHubAPI.getCurrentUser
        do {
            return try await networkManager.request(request)
        } catch {
            throw error
        }
    }
    
    func getUser(forUsername username: String) async throws -> User {
        let request = GitHubAPI.getUser(username: username)
        do {
            return try await networkManager.request(request)
        } catch {
            throw error
        }
    }
    
    func searchUser(forUsername username: String) async throws -> Users {
        let request = GitHubAPI.searchUser(query: username)
        do {
            return try await networkManager.request(request)
        } catch {
            throw error
        }
    }
    
    func getUserRepos(username: String) async throws -> [Repo] {
        let request = GitHubAPI.getUserRepos(username: username)
        do {
            return try await networkManager.request(request)
        } catch {
           throw error
        }
    }
    
    func checkIfUserFollowing(username: String) async throws -> Bool {
        let request = GitHubAPI.checkIfUserFollowing(username: username)
        do {
            return try await networkManager.requestIsStatusValid(request)
        } catch {
            throw error
        }
    }
    
    func follow(username: String) async throws {
        let request = GitHubAPI.follow(username: username)
        do {
            let success = try await networkManager.requestIsStatusValid(request)
            if success {
                return
            } else {
                throw GitHubError.followFailed
            }
        } catch {
            throw error
        }
    }
    
    func unfollow(username: String) async throws {
        let request = GitHubAPI.unfollow(username: username)
        do {
            let success = try await networkManager.requestIsStatusValid(request)
            if success {
                return
            } else {
                throw GitHubError.unfollowFailed
            }
        } catch {
            throw error
        }
    }
}
