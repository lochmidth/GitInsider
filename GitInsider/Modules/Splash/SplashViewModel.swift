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
    let gitHubService: GitHubServicing
    let userDefaults: UserDefaults
    
    init(keychain: KeychainSwift = KeychainSwift(), gitHubService: GitHubServicing = GitHubService(), userDefaults: UserDefaults = UserDefaults.standard) {
        self.keychain = keychain
        self.gitHubService = gitHubService
        self.userDefaults = userDefaults
    }
    
    func checkForAuth() {
        checkAndRemoveExpiredAccessToken()
        
        if let accessToken = keychain.get(accessTokenInKeychain), !accessToken.isEmpty {
            Task {
                let user = try await getCurrentUser()
                userDefaults.set(user.login, forKey: authUsername)
                DispatchQueue.main.async {
                    self.coordinator?.didFinishAuth(withUser: user)
                }
            }
        } else {
            coordinator?.goToLoginPage()
        }
    }
    
    func getCurrentUser() async throws -> User {
        return try await gitHubService.getCurrentUser()
    }
    
    func checkAndRemoveExpiredAccessToken() {
        if let expirationDate = userDefaults.value(forKey: accessTokenExpirationKeyInDefaults) as? Date,
           expirationDate < Date() {
            keychain.delete(accessTokenInKeychain)
            userDefaults.removeObject(forKey: accessTokenExpirationKeyInDefaults)
        }
    }
    
}
