//
//  SplashViewModel.swift
//  GitInsider
//
//  Created by Alphan Ogün on 14.11.2023.
//

import UIKit
import KeychainSwift

class SplashViewModel {
    var coordinator: AuthCoordinator?
    let keychain: KeychainSwift
    let gitHubService: GitHubService
    
    init(keychain: KeychainSwift = KeychainSwift(), gitHubService: GitHubService = GitHubService()) {
        self.keychain = keychain
        self.gitHubService = gitHubService
    }
    
    func checkForAuth() {
        if let accessToken = keychain.get("Access Token"), !accessToken.isEmpty {
            Task {
                let user = try await getCurrentUser()
                UserDefaults.standard.set(user.login, forKey: "Authenticated username")
                DispatchQueue.main.async {
                    self.coordinator?.didFinishAuth(withUser: user)
                }
            }
        } else {
            coordinator?.goToLoginPage()
        }
    }
    
    private func getCurrentUser() async throws -> User {
        return try await gitHubService.getCurrentUser()
    }
    
}
