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
    
    let gitHubService: GitHubServicing
    let keychain: KeychainSwift
    let notificationCenter: NotificationCenter
    let userDefaults: UserDefaults
    
    //MARK: - Lifecycle
    
    init(gitHubService: GitHubServicing = GitHubService(), keychain: KeychainSwift = KeychainSwift(), notificationCenter: NotificationCenter = NotificationCenter.default, userDefaults: UserDefaults = UserDefaults.standard) {
        self.gitHubService = gitHubService
        self.keychain = keychain
        self.notificationCenter = notificationCenter
        self.userDefaults = userDefaults
        
        notificationCenter.addObserver(self, selector: #selector(handleReceiveCode(_:)), name: .didReceiveCode, object: nil)
    }
    
    deinit {
        notificationCenter.removeObserver(self)
    }
    
    //MARK: - Actions
    
    @objc func handleReceiveCode(_ notification: Notification) {
        guard let code = notification.userInfo?["code"] as? String else { return }
        Task {
            let accessTokenResponse = try await gitHubService.exchangeToken(code: code)
            print("DEBUG: Access Token is received: \(accessTokenResponse.accessToken)")
            keychain.set(accessTokenResponse.accessToken, forKey: accessTokenInKeychain)
            setExpirationDate()

            let user = try await getCurrentUser()
            userDefaults.set(user.login, forKey: authUsername)
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
    
    private func setExpirationDate() {
        let expirationDate = Date().addingTimeInterval(TimeInterval(8 * 60 * 60))
        userDefaults.set(expirationDate, forKey: accessTokenExpirationKeyInDefaults)
    }
}
