//
//  HomeViewModel.swift
//  GitInsider
//
//  Created by Alphan Ogün on 14.11.2023.
//

import Foundation
import KeychainSwift

class HomeViewModel {
    //MARK: - Properties
    var user: User?
    var users: Users?
    let keychain: KeychainSwift
    let gitHubService: GitHubService
    weak var coordinator: AppCoordinator?
    
    var authLogin: String {
        user?.login ?? ""
    }
    
    var profileImageUrl: URL? {
        URL(string: user?.avatarUrl ?? "")
    }
    
    var nameText: String {
        if let name = user?.name?.components(separatedBy: " ").first {
            return "Hi \(name)!"
        }
        return "Hi \(user?.login ?? "User")!" 
    }
    
    var greetingText: String {
        let hour = Calendar.current.component(.hour, from: Date())
        var greeting: String
        switch hour {
        case 0..<12:
            greeting = "Good morning."
        case 12..<18:
            greeting = "Good afternoon."
        default:
            greeting = "Good evening."
        }
        return greeting
    }
    
    //MARK: - Lifecycle
    
    init(user: User?, gitHubService: GitHubService = GitHubService(), keychain: KeychainSwift = KeychainSwift()) {
        self.gitHubService = gitHubService
        self.user = user
        self.keychain = keychain
    }
    
    //MARK: - Helpers
    
    func handleSignOut() {
        keychain.delete("Access Token")
        coordinator?.signOut()
    }
    
    func goToProfile(withUser user: User, authLogin: String) {
        coordinator?.goToProfile(withUser: user, authLogin: authLogin)
    }
    
    func getUser(forUsername username: String, completion: @escaping(User) -> Void) {
        gitHubService.getUser(forUsername: username) { result in
            switch result {
            case .success(let user):
                completion(user)
            case .failure(let error):
                print("DEBUG: Error while fetching user with username, \(error.localizedDescription)")
            }
        }
    }
    
    func searchUser(forUsername username: String, completion: @escaping() -> Void) {
        gitHubService.searchUser(forUsername: username) { [weak self] result in
            switch result {
            case .success(let users):
                self?.users = users
                completion()
            case .failure:
                self?.users = nil
                completion()
            }
        }
    }
}
