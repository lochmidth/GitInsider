//
//  ProfileViewModel.swift
//  GitInsider
//
//  Created by Alphan Ogün on 16.11.2023.
//

import Foundation

class ProfileViewModel {
    let gitHubService: GitHubService
    var user: User
    var repos = [Repo]()
    var authLogin: String
    var coordinator: AppCoordinator?
    
    init(user: User, gitHubService: GitHubService = GitHubService()) {
        self.user = user
        self.gitHubService = gitHubService
        self.authLogin = UserDefaults.standard.object(forKey: "Authenticated username") as! String
    }
    
    func checkIfUserFollowing(username: String, completion: @escaping(Bool) -> Void) {
        gitHubService.checkIfUserFollowing(username: username) { result in
            switch result {
            case .success(let followingStatus):
                completion(followingStatus)
            case .failure(let error):
                print("DEBUG: Error while fecthing following information, \(error.localizedDescription)")
            }
        }
    }
    
    func follow(username: String, completion: @escaping() -> Void) {
        gitHubService.follow(username: username) { result in
            switch result {
            case .success:
                completion()
            case .failure(let error):
                print("DEBUG: Error while following the user, \(error.localizedDescription)")
            }
        }
    }
    
    func unfollow(username: String, completion: @escaping() -> Void) {
        gitHubService.unfollow(username: username) { result in
            switch result {
            case .success:
                completion()
            case .failure(let error):
                print("DEBUG: Error while unfollowing the user, \(error.localizedDescription)")
            }
        }
    }
    
    func getUserRepos() async throws {
        self.repos = try await gitHubService.getUserRepos(username: user.login)
    }
    
}
