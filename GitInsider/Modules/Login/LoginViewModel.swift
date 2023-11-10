//
//  LoginViewModel.swift
//  GitInsider
//
//  Created by Alphan Ogün on 8.11.2023.
//

import UIKit

class LoginViewModel {
    weak var coordinator: AppCoordinator!
    
    func goToLogin() {
        coordinator.goToLoginOnSafari()
    }
    
    func goToSignUp() {
        coordinator.goToSignUpOnSafari()
    }
    
    
}
