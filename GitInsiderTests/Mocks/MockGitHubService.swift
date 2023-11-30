//
//  MockGitHubService.swift
//  GitInsiderTests
//
//  Created by Alphan Ogün on 29.11.2023.
//

import Foundation
@testable import GitInsider

class MockGitHubService: GitHubServicing {
    var result: Result<Any, Error>?
    var isUserFollowing: Bool?
    
    var isExchangeTokenCalled = false
    func exchangeToken(code: String) async throws -> AccessTokenResponse {
        isExchangeTokenCalled = true
        
        if let result = result {
            switch result {
            case .success(let response):
                return response as! AccessTokenResponse
            case .failure(let error):
                throw error
            }
        } else {
            throw MockError.someError
        }
    }
    
    var isGetCurrentUserCalled = false
    var resultForUser: Result<User, Error>?
    func getCurrentUser() async throws -> User {
        isGetCurrentUserCalled = true
        
        if let result = resultForUser {
            switch result {
            case .success(let user):
                return user
            case .failure(let error):
                throw error
            }
        } else {
            throw MockError.someError
        }
    }
    
    var isGetUserCalled = false
    func getUser(forUsername username: String) async throws -> User {
        isGetUserCalled = true
        
        if let result = result {
            switch result {
            case .success(let user):
                return user as! User
            case .failure(let error):
                throw error
            }
        } else {
            throw MockError.someError
        }
    }
    
    var isSearchUserCalled = false
    func searchUser(forUsername username: String) async throws -> Users {
        isSearchUserCalled = true
        
        if let result = result {
            switch result {
            case .success(let users):
                return users as! Users
            case .failure(let error):
                throw error
            }
        } else {
            throw MockError.someError
        }
    }
    
    var isGetUserReposCalled = false
    func getUserRepos(username: String) async throws -> [Repo] {
        isGetUserReposCalled = true
        
        if let result = result {
            switch result {
            case .success(let repos):
                return repos as! [Repo]
            case .failure(let error):
                throw error
            }
        } else {
            throw MockError.someError
        }
    }
    
    var isCheckIfUserFollowingCalled = false
    func checkIfUserFollowing(username: String) async throws -> Bool {
        if let isFollowing = isUserFollowing {
            return isFollowing
        } else {
            throw MockError.someError
        }
    }
    
    var isFollowCalled = false
    func follow(username: String) async throws {
        isFollowCalled = true
    }
    
    var isUnfollowCalled = false
    func unfollow(username: String) async throws {
        isUnfollowCalled = true
    }
    
    
}
