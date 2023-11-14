//
//  SideMenuViewModel.swift
//  GitInsider
//
//  Created by Alphan Ogün on 9.11.2023.
//

import Foundation

class SideMenuViewModel {
    
    let gitHubService: GitHubService
    
    init(gitHubService: GitHubService = GitHubService()) {
        self.gitHubService = gitHubService
    }
    
    func getCurrentUser(completion: @escaping(User) -> Void) {
        gitHubService.getCurrentUser { result in
            switch result {
            case .success(let user):
                completion(user)
            case .failure(let error):
                print("DEBUG: Error while fetching user in SideMenuViewModel, \(error.localizedDescription)")
            }
        }
    }
    
}
