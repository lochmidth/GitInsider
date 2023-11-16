//
//  ProfileViewModel.swift
//  GitInsider
//
//  Created by Alphan Ogün on 16.11.2023.
//

import Foundation

class ProfileViewModel {
    
    var user: User
    var coordinator: AppCoordinator?
    
    init(user: User) {
        self.user = user
    }
    
}
