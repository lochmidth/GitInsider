//
//  ProfileViewModel.swift
//  GitInsider
//
//  Created by Alphan Ogün on 16.11.2023.
//

import Foundation

class ProfileViewModel {
    let gitHubService: GitHubServicing
    var user: User
    var repos = [Repo]()
    var authLogin: String
    var coordinator: HomeCoordinator?
    
    init(user: User, gitHubService: GitHubServicing = GitHubService()) {
        self.user = user
        self.gitHubService = gitHubService
        self.authLogin = UserDefaults.standard.object(forKey: authUsername) as! String
    }
    
    func configureProfileHeaderViewModel() async throws -> ProfileHeaderViewModel {
        if user.login == authLogin {
            return ProfileHeaderViewModel(user: user, followingStatus: false, config: .editProfile)
        } else {
            let isFollowing = try await checkIfUserFollowing()
            return ProfileHeaderViewModel(user: user, followingStatus: isFollowing)
        }
    }
    
    func checkIfUserFollowing() async throws -> Bool {
        return try await gitHubService.checkIfUserFollowing(username: user.login)
    }
    
    func follow(username: String) async throws {
        try await gitHubService.follow(username: username)
        return
    }
    
    func unfollow(username: String) async throws {
        try await gitHubService.unfollow(username: username)
        return
    }
    
    func getUserRepos() async throws {
        self.repos = try await gitHubService.getUserRepos(username: user.login)
    }
    
    func didSelectRowAt(index: Int) {
        guard let url = URL(string: repos[index].htmlUrl) else { return }
        coordinator?.goToSafari(withUrl: url)
    }
    
}
