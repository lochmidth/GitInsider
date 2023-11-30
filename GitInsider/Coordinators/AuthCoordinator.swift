//
//  AuthCoordinator.swift
//  GitInsider
//
//  Created by Alphan Ogün on 27.11.2023.
//

import UIKit

class AuthCoordinator: Coordinator {
    var navigationController: UINavigationController
    weak var parentCoordinator: AppCoordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        goToSplash()
    }
    
    private func goToSplash() {
        let splashController = SplashController()
        let splashViewModel = SplashViewModel()
        splashViewModel.coordinator = self
        splashController.viewModel = splashViewModel
        navigationController.pushViewController(splashController, animated: false)
    }
    
    func goToLoginPage() {
        let loginController = LoginController()
        let loginViewModel = LoginViewModel()
        loginViewModel.coordinator = self
        loginController.viewModel = loginViewModel
        navigationController.pushViewController(loginController, animated: false)
    }
    
    func goToLoginOnSafari() {
        guard let url = URL(string: gitHubAuthLink) else { return }
        let webController = WebController(url: url)
        let webViewModel = WebViewModel()
//        webViewModel.coordinator = self
        webController.viewModel = webViewModel
        navigationController.present(webController, animated: true)
    }
    
    func goToSignUpOnSafari() {
        guard let url = URL(string: gitHubSignupLink) else { return }
        let webController = WebController(url: url)
        let webViewModel = WebViewModel()
//        webViewModel.coordinator = self
        webController.viewModel = webViewModel
        navigationController.present(webController, animated: true)
    }
    
    func didFinishAuth(withUser user: User) {
        parentCoordinator?.childDidFinish(self)
        navigationController.dismiss(animated: true)
        navigationController.popToRootViewController(animated: false)
        parentCoordinator?.goToHome(withUser: user)
    }
}
