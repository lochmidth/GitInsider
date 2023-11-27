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
    weak var coordinator: HomeCoordinator?
    
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
    
    func goToProfile(withUser user: User) {
        coordinator?.goToProfile(withUser: user)
    }
    
    func getUser(forUsername username: String) async throws -> User {
        return try await gitHubService.getUser(forUsername: username)
    }
    
    func handleCellImageVisibility() -> Bool {
        if users?.items.isEmpty == false {
            return true
        } else {
            return false
        }
    }
    
    func searchUser(forUsername username: String) async throws {
        if username == "" {
            self.users = nil
        } else {
            self.users = try await gitHubService.searchUser(forUsername: username)
        }
        
        
    }
    
    func didSelectItemAt(index: Int) {
        guard let username = users?.items[index].login else { return }
        Task {
            let user = try await getUser(forUsername: username)
            DispatchQueue.main.async {
                self.goToProfile(withUser: user)
            }
        }
    }
}
