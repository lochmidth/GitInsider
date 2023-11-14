//
//  SplashViewModel.swift
//  GitInsider
//
//  Created by Alphan Ogün on 14.11.2023.
//

import UIKit
import KeychainSwift

class SplashViewModel {
    var coordinator: AppCoordinator?
    let keychain: KeychainSwift
    let gitHubService: GitHubService
    
    init(keychain: KeychainSwift = KeychainSwift(), gitHubService: GitHubService = GitHubService()) {
        self.keychain = keychain
        self.gitHubService = gitHubService
    }
    
    func checkForAuth() {
        if let accessToken = keychain.get("Access Token"), !accessToken.isEmpty {
            getCurrentUser { [weak self] user in
                self?.coordinator?.goToHome(withUser: user)
            }
        } else {
            coordinator?.goToLoginPage()
        }
    }
    
    private func getCurrentUser(completion: @escaping(User) -> Void) {
        gitHubService.getCurrentUser { result in
            switch result {
            case .success(let user):
                completion(user)
            case .failure(let error):
                print("DEBUG: Error while fetching user data, \(error.localizedDescription)")
            }
        }
    }
    
}
