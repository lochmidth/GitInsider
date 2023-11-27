//
//  LoginViewModel.swift
//  GitInsider
//
//  Created by Alphan Ogün on 8.11.2023.
//

import UIKit
import KeychainSwift

class LoginViewModel {
    
    //MARK: - Properties
    
    weak var coordinator: AuthCoordinator?
    
    let gitHubService: GitHubService
    let keychain: KeychainSwift
    
    //MARK: - Lifecycle
    
    init(gitHubService: GitHubService = GitHubService(), keychain: KeychainSwift = KeychainSwift()) {
        self.gitHubService = gitHubService
        self.keychain = keychain
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleReceiveCode(_:)), name: .didReceiveCode, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: - Actions
    
    @objc func handleReceiveCode(_ notification: Notification) {
        guard let code = notification.userInfo?["code"] as? String else { return }
        Task {
            let accessTokenResponse = try await gitHubService.exchangeToken(code: code)
            print("DEBUG: Access Token is received: \(accessTokenResponse.accessToken)")
            keychain.set(accessTokenResponse.accessToken, forKey: "Access Token")

            let user = try await getCurrentUser()
            UserDefaults.standard.set(user.login, forKey: "Authenticated username")
            DispatchQueue.main.async {
                self.coordinator?.didFinishAuth(withUser: user)
            }
        }
    }
    
    //MARK: - Helpers
    
    func goToLogin() {
        coordinator?.goToLoginOnSafari()
    }
    
    func goToSignUp() {
        coordinator?.goToSignUpOnSafari()
    }
    
    private func getCurrentUser() async throws -> User {
        return try await gitHubService.getCurrentUser()
    }
}
