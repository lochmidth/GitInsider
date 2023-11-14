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
    
    weak var coordinator: AppCoordinator?
    
    let oAuthManager: OAuthManager
    let gitHubService: GitHubService
    let keychain: KeychainSwift
    
    //MARK: - Lifecycle
    
    init(oAuthManager: OAuthManager = OAuthManager(), gitHubService: GitHubService = GitHubService(), keychain: KeychainSwift = KeychainSwift()) {
        self.oAuthManager = oAuthManager
        self.gitHubService = gitHubService
        self.keychain = keychain
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleReceivedUrl(_:)), name: .didReceiveURL, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: - Actions
    
    @objc func handleReceivedUrl(_ notification: Notification) {
        guard let url = notification.userInfo?["url"] as? URL else { return }
        Task {
            let code = try await oAuthManager.handleCallBack(withUrl: url)
            let accessTokenResponse = try await gitHubService.exchangeToken(code: code)
            print("DEBUG: Access Token is received: \(accessTokenResponse.accessToken)")
            keychain.set(accessTokenResponse.accessToken, forKey: "Access Token")
            
            DispatchQueue.main.async {
                self.coordinator?.goToContainer()
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
    
    
}
