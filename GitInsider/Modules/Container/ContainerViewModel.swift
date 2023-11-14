//
//  ContainerViewModel.swift
//  GitInsider
//
//  Created by Alphan Ogün on 9.11.2023.
//

import Foundation

class ContainerViewModel {
    
    //MARK: - Properties
    
    weak var coordinator: AppCoordinator?
    
    var user: User?
    let gitHubService: GitHubService
    
    init(gitHubService: GitHubService = GitHubService()) {
        self.gitHubService = gitHubService
        
    }
    
    //MARK: - Helpers

    
}
