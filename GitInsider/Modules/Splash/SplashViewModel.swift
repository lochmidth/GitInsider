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
        checkAndRemoveExpiredAccessToken()
        
        if let accessToken = keychain.get(accessTokenInKeychain), !accessToken.isEmpty {
            Task {
                let user = try await getCurrentUser()
                UserDefaults.standard.set(user.login, forKey: authUsername)
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
    
    private func checkAndRemoveExpiredAccessToken() {
        if let expirationDate = UserDefaults.standard.value(forKey: accessTokenExpirationKeyInDefaults) as? Date,
           expirationDate < Date() {
            keychain.delete(accessTokenInKeychain)
            UserDefaults.standard.removeObject(forKey: accessTokenExpirationKeyInDefaults)
        }
    }
    
}
