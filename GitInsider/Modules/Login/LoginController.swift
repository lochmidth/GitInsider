//
//  LoginController.swift
//  GitInsider
//
//  Created by Alphan Ogün on 8.11.2023.
//

import UIKit

class LoginController: UIViewController {
    //MARK: - Properties
    
    let loginView = LoginView()
    var viewModel: LoginViewModel?
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureNavigationBar()
    }
    
    override func loadView() {
        view = loginView
        loginView.delegate = self
    }
    
    deinit {
        print("DEBUG: \(self) deallocated.")
    }
    
    //MARK: - Helpers
    
    func configureNavigationBar() {
        navigationController?.navigationBar.isHidden = true
    }
}

extension LoginController: LoginViewDelegate {
    func handleLogin() {
        viewModel?.goToLogin()
    }
    
    func handleShowSignUp() {
        viewModel?.goToSignUp()
    }
}

