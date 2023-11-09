//
//  LoginViewModel.swift
//  GitInsider
//
//  Created by Alphan Ogün on 8.11.2023.
//

import UIKit

class LoginViewModel {
    weak var coordinator: AppCoordinator!
    
    var email: String?
    var password: String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false && password?.isEmpty == false
    }
    
    var buttonBackgroundColor: UIColor {
        return formIsValid ? .black : .black.withAlphaComponent(0.5)
    }
    
    var buttonTitleColor: UIColor {
        return formIsValid ? .white : UIColor(white: 1, alpha: 0.67)
    }
    
    func goToSignUp() {
        coordinator.goToSignUpOnSafari()
    }
    
    
}
